require 'poise'

module UnboundConfig
  class Resource < Chef::Resource
    include Poise

    provides :unbound_config

    actions :create, :delete, :insert

    attribute :path, kind_of: String, name_attribute: true
    attribute :config, kind_of: Hash, required: true
    attribute :owner, kind_of: String, default: 'root'
    attribute :group, kind_of: String, default: 'root'
    attribute :mode, kind_of: String, default: '0644'
  end

  class Provider < Chef::Provider
    include Poise

    provides :unbound_config

    # Instead of managing the whole file, insert configuration line(s)
    # This is a special action. If in doubt, use the `:create` action instead.
    # * Does not manage the file attributes (owner, group, mode)
    # * Does not handle nested hash configuration - Only writes a simple "key: value" type configuration
    # * Especially useful for managing the include directive in /etc/unbound/unbound.conf
    def action_insert
      path = new_resource.path

      new_resource.config.each do |k,v|
        match_string = /#{Regexp.escape(k)}:\s*"?#{Regexp.escape(v)}"?/
        insert_string = "#{k}: #{v}"

        if ::File.exist?(path) && ::File.readlines(path).grep(match_string).size == 0
          converge_by "insert '#{insert_string}' in configuration file #{path}" do
            notifying_block do
              file = Chef::Util::FileEdit.new(path)
              file.insert_line_if_no_match(match_string, insert_string)
              file.write_file
              new_resource.updated_by_last_action(true)
            end
          end
        end
      end
    end

    def action_create
      notifying_block do
        template new_resource.path do
          source 'config.erb'
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
          variables config: new_resource.config
        end
      end
    end
  end
end
