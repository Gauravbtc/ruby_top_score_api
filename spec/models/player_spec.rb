require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "creation" do
    let (:player) { FactoryBot.create(:player)}
    it "can be created" do
      expect(player).to be_valid
    end

    it "can't be created without name" do
      player.name = nil
      expect(player).to be_invalid
    end
  end

  describe "validation" do
    let (:player) { FactoryBot.create(:player)}
    it "name can't be blank" do
      player.name = nil
      expect(player.save).to be_falsy
    end

    it "name must be uniq" do
      new_player = FactoryBot.build(:player,name: player.name)
      expect(new_player.valid?).to be_falsy
    end
  end
end
