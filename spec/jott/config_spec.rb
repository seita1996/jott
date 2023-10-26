# frozen_string_literal: true

require 'spec_helper'
require 'jott/config'

RSpec.describe Config do
  after(:all) do
    Config.new.set_editor('vi')
  end

  describe '#set_editor' do
    context 'when editor is set' do
      it 'the editor is set' do
        Config.new.set_editor('vim')
        expect(Config.new.editor).to eq 'vim'
      end
    end
  end
end
