require 'rails_helper'

RSpec.describe Score, type: :model do
  describe "creation" do
    let (:score) { FactoryBot.create(:score)}
    it "can be created" do
      expect(score).to be_valid
    end

    it "can't be created without score and time" do
      score.time = nil
      score.score = nil
      expect(score).to be_invalid
    end
  end

  describe "validation" do
    let (:score) { FactoryBot.create(:score)}
    it "score can't be blank" do
      score.value = nil
      expect(score.save).to be_falsy
    end

    it "score can't be string" do
      score.score = "hello"
      expect(score.save).to be_falsy
    end

    it "score must be pstive number" do
      score.score = -10
      expect(score.save).to be_falsy
    end

    it "player name can't be blank" do
      score.name = nil
      expect(score.save).to be_falsy
    end
  end
end
