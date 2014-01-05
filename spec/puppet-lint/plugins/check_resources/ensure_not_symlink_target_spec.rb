require 'spec_helper'

describe 'ensure_not_symlink_target' do
  let(:msg) { 'symlink target specified in ensure attr' }

  context 'file resource creating a symlink with seperate target attr' do
    let(:code) { "
      file { 'foo':
        ensure => link,
        target => '/foo/bar',
      }"
    }

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'file resource creating a symlink with target specified in ensure' do
    let(:code) { "
      file { 'foo':
        ensure => '/foo/bar',
      }"
    }

    it 'should only detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create a warning' do
      expect(problems).to contain_warning(msg).on_line(3).in_column(19)
    end
  end
end