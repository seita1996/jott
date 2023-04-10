require 'spec_helper'
require 'jott/cli'

RSpec.describe CLI do
  after(:all) do
    Memo.new.clear
  end

  describe "#clear" do
    context "when executed" do
      let!(:memo1) { Memo.new.create(title: 'test1', body: 'test1') }
      let!(:memo2) { Memo.new.create(title: 'test2', body: 'test2') }

      it "clear message is displayed in green." do
        expect {
          CLI.start(['clear'])
        }.to output('Clear all memos'.colorize(:green).concat("\n")).to_stdout
      end

      it "all memos are deleted." do
        CLI.start(['clear'])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq 0
      end
    end
  end

  describe "#add" do
    context "when command executed by over 30 chars args" do
      let(:text) { 'There is always light behind the clouds.' }

      it "added message and the first 30 chars of the memo added are displayed in green." do
        first_30_chars = 'There is always light behind t'
        expect {
          CLI.start(['add', text])
        }.to output("Added new memo: #{first_30_chars}".colorize(:green).concat("\n")).to_stdout
      end

      it "adds a new memo" do
        init_count = Memo.new.count[0][0]
        CLI.start(['add', text])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count + 1
      end

      it "the title of the new memo is the first 30 chars of the memo." do
        first_30_chars = 'There is always light behind t'
        CLI.start(['add', text])
        expect(Memo.new.last[0][2]).to eq first_30_chars
      end

      it "the body of the new memo is the text entered." do
        CLI.start(['add', text])
        expect(Memo.new.last[0][3]).to eq text
      end
    end

    context "when command executed by under 30 chars args" do
      let(:text) { 'Hi Bob.' }

      it "added message and the memo added are displayed in green." do
        expect {
          CLI.start(['add', text])
        }.to output("Added new memo: #{text}".colorize(:green).concat("\n")).to_stdout
      end

      it "adds a new memo" do
        init_count = Memo.new.count[0][0]
        CLI.start(['add', text])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count + 1
      end

      it "the title of the new memo is the text entered." do
        CLI.start(['add', text])
        expect(Memo.new.last[0][2]).to eq text
      end

      it "the body of the new memo is the text entered." do
        CLI.start(['add', text])
        expect(Memo.new.last[0][3]).to eq text
      end
    end

    context "when command executed by multiple text args" do
      let(:arg) { ['Hi', 'Bob.', 'How', 'are', 'you?'] }

      it "added message and the memo added are displayed in green." do
        expect {
          CLI.start(['add', arg])
        }.to output("Added new memo: #{arg.join(' ')}".colorize(:green).concat("\n")).to_stdout
      end

      it "adds a new memo" do
        init_count = Memo.new.count[0][0]
        CLI.start(['add', arg])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count + 1
      end
    end

    # TODO: Add tests for anomalous systems
  end

  describe "#rm" do
    context "when an existing id is passed as an arg" do
      let(:memo) { Memo.new.create(title: 'test', body: 'test') }
      let(:id) { Memo.new.last[0][0] }

      it "deleted message and the id are displayed in green." do
        expect {
          CLI.start(['rm', id])
        }.to output("Deleted the memo: #{id}".colorize(:green).concat("\n")).to_stdout
      end

      it "deletes the memo" do
        memo
        init_count = Memo.new.count[0][0]
        CLI.start(['rm', id])
        final_count = Memo.new.count[0][0]
        expect(final_count).to eq init_count - 1
      end
    end

    # TODO: Add tests for anomalous systems
  end

  describe "#ls" do
    context "when executed" do
      let(:memo1) { Memo.new.create(title: 'test1', body: 'test1') }
      let(:memo2) { Memo.new.create(title: 'test2', body: 'test2') }

      it "memo records (id. title: body) are displayed in order of oldest to newest." do
        Memo.new.clear
        memo1
        memo2
        expect {
          CLI.start(['ls'])
        }.to output("1. test1: test1\n2. test2: test2\n").to_stdout
      end
    end
  end

  describe "#version" do
    context "when executed" do
      it "shows version" do
        expect {
          CLI.start(['version'])
        }.to output("jott version #{Jott::VERSION}\n").to_stdout
      end
    end
  end
end
