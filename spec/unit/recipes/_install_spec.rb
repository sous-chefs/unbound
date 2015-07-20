#
# Cookbook Name:: unbound
# Spec:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe 'unbound::default' do
  context 'with default attributes' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5')
        .converge(described_recipe)
    end
    subject { chef_run }

    it { is_expected.to include_recipe('yum-epel') }
    it { is_expected.to upgrade_package('unbound') }
  end

  context 'with non-default attributes' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5') do |node|
        node.set['unbound']['manage_package_repo'] = false
        node.set['unbound']['package_name'] = 'unbound-special'
        node.set['unbound']['package_action'] = :install
      end.converge(described_recipe)
    end
    subject { chef_run }

    it { is_expected.not_to include_recipe('yum-epel') }
    it { is_expected.to install_package('unbound-special') }
  end

  context 'with debian' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'debian', version: '7.6')
        .converge(described_recipe)
    end
    subject { chef_run }

    it { is_expected.not_to include_recipe('yum-epel') }
  end
end
