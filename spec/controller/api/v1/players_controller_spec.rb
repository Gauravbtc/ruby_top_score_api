require "rails_helper"

describe Api::V1::PlayersController, type: :controller do
  describe "GET Player histroy" do
    it "will get histroy of given player" do
      score_1 = FactoryBot.create(:score, name: "David")
      score_2 = FactoryBot.create(:score, name: "David")
      score_3 = FactoryBot.create(:score, name: "David")
      get :history, params: {id: score_1.player.id }
      player = JSON.parse(response.body)
      expect(player["success"]).to eq(true)
      expect(response.status).to eq(200)
    end

    it "will raise an error when given player is not avaible" do
      score_1 = FactoryBot.create(:score, name: "David")
      get :history, params: {id: "adasd" }
      player = JSON.parse(response.body)
      expect(player["success"]).to eq(false)
    end
  end
end
