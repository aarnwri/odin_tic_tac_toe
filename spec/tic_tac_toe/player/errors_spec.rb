# frozen_string_literal: true

require_relative "../../../lib/tic_tac_toe"

RSpec.shared_examples "for a StandardError" do
  it "is a StandardError" do
    expect(described_class).to be < StandardError
  end
end

RSpec.describe TicTacToe::Player::InvalidTokenError do
  include_examples "for a StandardError"

  describe "#initialize" do
    let(:err) { described_class.new("", "Z") }

    it "uses the token in the error message, explaining the problem" do
      expect(err.message).to match(/Token \(Z\) is invalid./)
    end

    it "offers a solution in the error message, using valid tokens" do
      expect(err.message).to match(/It must be one of #{TicTacToe::Player::TOKENS.join(', ')}/)
    end
  end
end

RSpec.describe TicTacToe::Player do
  describe "::ERRORS" do
    it "returns an array of all defined Player Error classes" do
      expect(described_class::ERRORS).to include(described_class::InvalidTokenError)
    end
  end
end
