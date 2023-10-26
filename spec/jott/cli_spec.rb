# frozen_string_literal: true

require 'spec_helper'
require 'jott/cli'

RSpec.describe CLI do
  after(:all) do
    Memo.new.clear
  end

  describe '#clear' do
    context 'when executed' do
      let!(:memo1) { Memo.new.create(title: 'test1', body: 'test1') }
      let!(:memo2) { Memo.new.create(title: 'test2', body: 'test2') }

      it 'clear message is displayed in green.' do
        expect do
          CLI.start(['clear'])
        end.to output('Clear all memos'.colorize(:green).concat("\n")).to_stdout
      end

      it 'all memos are deleted.' do
        CLI.start(['clear'])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq 0
      end
    end
  end

  describe '#add' do
    context 'when command executed by over 30 chars args' do
      let(:text) { 'There is always light behind the clouds.' }

      it 'added message and the first 30 chars of the memo added are displayed in green.' do
        first_30_chars = 'There is always light behind t'
        expect do
          CLI.start(['add', text])
        end.to output("Added new memo: #{first_30_chars}".colorize(:green).concat("\n")).to_stdout
      end

      it 'adds a new memo' do
        init_count = Memo.new.count[0][0]
        CLI.start(['add', text])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count + 1
      end

      it 'the title of the new memo is the first 30 chars of the memo.' do
        first_30_chars = 'There is always light behind t'
        CLI.start(['add', text])
        expect(Memo.new.last[0][2]).to eq first_30_chars
      end

      it 'the body of the new memo is the text entered.' do
        CLI.start(['add', text])
        expect(Memo.new.last[0][3]).to eq text
      end
    end

    context 'when command executed by under 30 chars args' do
      let(:text) { 'Hi Bob.' }

      it 'added message and the memo added are displayed in green.' do
        expect do
          CLI.start(['add', text])
        end.to output("Added new memo: #{text}".colorize(:green).concat("\n")).to_stdout
      end

      it 'adds a new memo' do
        init_count = Memo.new.count[0][0]
        CLI.start(['add', text])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count + 1
      end

      it 'the title of the new memo is the text entered.' do
        CLI.start(['add', text])
        expect(Memo.new.last[0][2]).to eq text
      end

      it 'the body of the new memo is the text entered.' do
        CLI.start(['add', text])
        expect(Memo.new.last[0][3]).to eq text
      end
    end

    context 'when command executed by multiple text args' do
      let(:arg) { ['Hi', 'Bob.', 'How', 'are', 'you?'] }

      it 'added message and the memo added are displayed in green.' do
        expect do
          CLI.start(['add', arg])
        end.to output("Added new memo: #{arg.join(' ')}".colorize(:green).concat("\n")).to_stdout
      end

      it 'adds a new memo' do
        init_count = Memo.new.count[0][0]
        CLI.start(['add', arg])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count + 1
      end
    end

    # Add tests open an editor
  end

  describe '#rm' do
    context 'when an existing id is passed as an arg' do
      let(:memo) { Memo.new.create(title: 'test', body: 'test') }
      let(:id) { Memo.new.last[0][0] }

      it 'deleted message and the id are displayed in green.' do
        expect do
          CLI.start(['rm', id])
        end.to output("Deleted the memo: #{id}".colorize(:green).concat("\n")).to_stdout
      end

      it 'deletes the memo' do
        memo
        init_count = Memo.new.count[0][0]
        CLI.start(['rm', id])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count - 1
      end
    end

    # TODO: Add tests for anomalous systems
  end

  describe '#edit' do
    let(:memo) { Memo.new.create(title: 'test', body: 'test') }
    let(:id) { Memo.new.last[0][0] }

    context 'when command executed by over 30 chars args' do
      let(:text) { 'There is always light behind the clouds.' }

      it 'edited message and the id are displayed in green.' do
        expect do
          CLI.start(['edit', id, text])
        end.to output("Edited the memo: #{id}".colorize(:green).concat("\n")).to_stdout
      end

      it 'does not add a new memo' do
        memo
        init_count = Memo.new.count[0][0]
        CLI.start(['edit', id, text])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count
      end

      it 'the title of the edited memo is the first 30 chars of the memo.' do
        first_30_chars = 'There is always light behind t'
        CLI.start(['edit', id, text])
        expect(Memo.new.last[0][2]).to eq first_30_chars
      end

      it 'the body of the edited memo is the text entered.' do
        CLI.start(['edit', id, text])
        expect(Memo.new.last[0][3]).to eq text
      end
    end

    context 'when command executed by under 30 chars args' do
      let(:text) { 'Hi Bob.' }

      it 'edited message and the memo edited are displayed in green.' do
        expect do
          CLI.start(['edit', id, text])
        end.to output("Edited the memo: #{id}".colorize(:green).concat("\n")).to_stdout
      end

      it 'does not add a new memo' do
        memo
        init_count = Memo.new.count[0][0]
        CLI.start(['edit', id, text])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count
      end

      it 'the title of the edited memo is the text entered.' do
        CLI.start(['edit', id, text])
        expect(Memo.new.last[0][2]).to eq text
      end

      it 'the body of the edited memo is the text entered.' do
        CLI.start(['edit', id, text])
        expect(Memo.new.last[0][3]).to eq text
      end
    end

    context 'when command executed by multiple text args' do
      let(:arg) { ['Hi', 'Bob.', 'How', 'are', 'you?'] }

      it 'edited message and the memo edited are displayed in green.' do
        expect do
          CLI.start(['edit', id, arg])
        end.to output("Edited the memo: #{id}".colorize(:green).concat("\n")).to_stdout
      end

      it 'does not add a new memo' do
        memo
        init_count = Memo.new.count[0][0]
        CLI.start(['edit', id, arg])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count
      end
    end

    # TODO: Add tests open an editor
  end

  describe '#ls' do
    context 'when executed' do
      let(:memo1) { Memo.new.create(title: 'test1', body: 'test1') }
      let(:memo2) { Memo.new.create(title: 'test2', body: 'test2') }

      it 'memo records (id. title) are displayed in order of oldest to newest.' do
        Memo.new.clear
        memo1
        memo2
        expect do
          CLI.start(['ls'])
        end.to output("1. test1\n2. test2\n").to_stdout
      end
    end
  end

  describe '#show' do
    context 'when an existing id is passed as an arg' do
      let(:memo) { Memo.new.create(title: 'test', body: 'test') }
      let(:id) { Memo.new.last[0][0] }

      it 'memo record (body) is displayed.' do
        Memo.new.clear
        memo
        expect do
          CLI.start(['show', id])
        end.to output("test\n").to_stdout
      end
    end
  end

  describe 'set-editor' do
    context 'when command executed by an editor name' do
      let(:editor) { 'vim' }

      it 'editor name is displayed in green.' do
        expect do
          CLI.start(['set-editor', editor])
        end.to output("Set editor: #{editor}".colorize(:green).concat("\n")).to_stdout
      end

      it 'editor name is saved in the config file.' do
        CLI.start(['set-editor', editor])
        expect(Config.new.editor).to eq editor
      end
    end

    context 'when command executed by an editor name with a space' do
      let(:editor) { 'vim -u NONE' }

      it 'editor name is displayed in green.' do
        expect do
          CLI.start(['set-editor', editor])
        end.to output("Set editor: #{editor}".colorize(:green).concat("\n")).to_stdout
      end

      it 'editor name is saved in the config file.' do
        CLI.start(['set-editor', editor])
        expect(Config.new.editor).to eq editor
      end
    end
  end

  describe '#config' do
    context 'when executed' do
      it 'editor name is displayed.' do
        expect do
          CLI.start(['config'])
        end.to output("editor: #{Config.new.editor}\n").to_stdout
      end
    end
  end

  describe '#version' do
    context 'when executed' do
      it 'shows version' do
        expect do
          CLI.start(['version'])
        end.to output("jott version #{Jott::VERSION}\n").to_stdout
      end
    end
  end
end
