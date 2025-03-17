# frozen_string_literal: true

require_relative "../../../lib/tic_tac_toe"

RSpec.shared_examples "for a StandardError" do
  it "is a StandardError" do
    expect(described_class).to be < StandardError
  end
end

RSpec.describe TicTacToe::Board::LocationFormatError do
  include_examples "for a StandardError"

  describe "#initialize" do
    let(:err) { described_class.new("", "a4") }

    it "uses the location in the error message" do
      expect(err.message).to match(/Location \(a4\)/)
    end

    it "explains the problem in the error message" do
      expect(err.message).to match(/not\scorrectly\sformatted/)
    end

    it "offers a solution in the error message" do
      expect(err.message).to match(/It\sshould/)
    end
  end
end

RSpec.describe TicTacToe::Board::BadRowError do
  include_examples "for a StandardError"

  describe "#initialize" do
    let(:err) { described_class.new("", "d") }

    it "uses the row in the error message" do
      expect(err.message).to match(/Row \(d\)/)
    end

    it "explains the problem in the error message" do
      expect(err.message).to match(/not\son\sboard/)
    end

    it "offers a solution in the error message" do
      expect(err.message).to match(/It\sshould/)
    end
  end
end

RSpec.describe TicTacToe::Board::BadColError do
  include_examples "for a StandardError"

  describe "#initialize" do
    let(:err) { described_class.new("", "4") }

    it "uses the row in the error message" do
      expect(err.message).to match(/Column \(4\)/)
    end

    it "explains the problem in the error message" do
      expect(err.message).to match(/not\son\sboard/)
    end

    it "offers a solution in the error message" do
      expect(err.message).to match(/It\sshould/)
    end
  end
end

RSpec.describe TicTacToe::Board::NonEmptyTileError do
  include_examples "for a StandardError"

  describe "#initialize" do
    let(:err) { described_class.new("", "a4") }

    it "uses the location in the error message" do
      expect(err.message).to match(/Location \(a4\)/)
    end

    it "explains the problem in the error message" do
      expect(err.message).to match(/not\sempty/)
    end
  end
end

RSpec.describe TicTacToe::Board do
  describe "::ERRORS" do
    it "returns an array of all defined Board Error classes" do
      expect(described_class::ERRORS).to include(described_class::LocationFormatError)
      expect(described_class::ERRORS).to include(described_class::BadRowError)
      expect(described_class::ERRORS).to include(described_class::BadColError)
      expect(described_class::ERRORS).to include(described_class::NonEmptyTileError)
    end
  end
end
