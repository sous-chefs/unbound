# frozen_string_literal: true

name 'unbound'

run_list 'test::default'

cookbook 'unbound', path: '.'
cookbook 'test', path: './test/cookbooks/test'

Dir.entries('./test/cookbooks/test/recipes').select { |f| !File.directory? f }.each do |test|
  test = test.delete_suffix('.rb')
  named_run_list :"#{test}", "test::#{test}"
end
