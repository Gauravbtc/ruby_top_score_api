require "rails_helper"

describe Api::V1::ScoresController, type: :controller do
  describe "POST score create action" do
    it "will create score of given player" do
      post :create, params: {score: { name: Faker::Name.unique.name, score: Faker::Number.number(digits: 2), time: Faker::Date.forward(days: 23)}}
      score = JSON.parse(response.body)
      expect(score["success"]).to eq(true)
      expect(response.status).to eq(200)
    end

    it "will not create score when the player name is empty" do
      post :create, params: {score: { name: nil, score: Faker::Number.number(digits: 2), time: Faker::Date.forward(days: 23)}}
      score = JSON.parse(response.body)
      expect(score["success"]).to eq(false)
      expect(response.status).to eq(422)
    end

    it "will not create score when the score is nagative" do
      post :create, params: {score: { name: Faker::Name.unique.name, score: -10, time: Faker::Date.forward(days: 23)}}
      score = JSON.parse(response.body)
      expect(score["success"]).to eq(false)
      expect(response.status).to eq(422)
    end
  end

  describe "GET Score show action" do
    let (:score) { FactoryBot.create(:score)}
    it "will show the score" do
      get :show, params: {id: score.id }
      score = JSON.parse(response.body)
      expect(score["success"]).to eq(true)
    end

    it "will throw an error when invalid id is passed in url" do
      get :show, params: {id: "dummy" }
      score = JSON.parse(response.body)
      expect(score["success"]).to eq(false)
    end
  end

  describe "DELETE Score show action" do
    let (:score) { FactoryBot.create(:score)}
    it "will delete score" do
      delete :destroy, params: {id: score.id }
      score = JSON.parse(response.body)
      expect(score["success"]).to eq(true)
    end

    it "will throw an error when invalid id is passed in url" do
      delete :destroy, params: {id: "dummy" }
      score = JSON.parse(response.body)
      expect(score["success"]).to eq(false)
    end
  end

  describe "GET index action" do
    it "will list score" do
      FactoryBot.create(:score)
      get :index
      scores = JSON.parse(response.body)
      expect(scores["success"]).to eq(true)
    end

    it "will search the score by player name" do
      score = FactoryBot.create(:score)
      get :index,params: {player: score.player}
      scores = JSON.parse(response.body)
      expect(scores["success"]).to eq(true)
      expect(scores["data"][0]["name"]).to eq(score.player.name)
    end

    it "will search the score by two player name" do
      score_player_1 = FactoryBot.create(:score)
      score_player_2 = FactoryBot.create(:score)
      get :index,params: {player: "#{score_player_1.player},#{score_player_2.player}"}
      scores = JSON.parse(response.body)
      expect(scores["success"]).to eq(true)
      expect(scores["data"].length).to eq(2)
    end

    it "will search the score by before specfic date" do
      score_player_1 = FactoryBot.create(:score, time: DateTime.now())
      score_player_2 = FactoryBot.create(:score, time: DateTime.now())
      time = DateTime.now() + 12.days
      get :index,params: {before: time}
      scores = JSON.parse(response.body)
      expect(scores["success"]).to eq(true)
      expect(scores["data"].length).to eq(2)
    end


    it "will search the score by after specfic date" do
      score_player_1 = FactoryBot.create(:score, time: DateTime.now())
      score_player_2 = FactoryBot.create(:score, time: DateTime.now())
      time = DateTime.now() - 1.year
      get :index,params: {after: time}
      scores = JSON.parse(response.body)
      expect(scores["success"]).to eq(true)
      expect(scores["data"].length).to eq(2)
    end

    it "will search the score by  plalyers name, before and after specfic date" do
      score_player_1 = FactoryBot.create(:score, time: DateTime.now())
      score_player_2 = FactoryBot.create(:score, time: DateTime.now())
      before_time = DateTime.now() + 12.days
      after_time = DateTime.now() - 1.year
      get :index,params: {playes: "#{score_player_1.name},#{score_player_2.name}", before: before_time, after: after_time}
      scores = JSON.parse(response.body)
      expect(scores["success"]).to eq(true)
      expect(scores["data"].length).to eq(2)
    end
  end

end
