class Score < ApplicationRecord
  ## Realstions
  belongs_to :player, inverse_of: :scores
  ## scopes
  include ScoreScope

  ## validates
  delegate :name, to: :player
  alias_attribute :time, :occured_at
  alias_attribute :score, :value

  validates :name, presence: true
  validates :time, presence: true
  validates :score, presence: true

  validates_each :score do |record, attr, value|
    if value.blank?
      record.errors.add(attr, "can't be blank")
    elsif !value.positive?
      record.errors.add(attr, 'must be a number greater then zero')
    end
  end

  validates_each :name do |record, attr, value|
    record.errors.add(attr, "can't be blank") if value.blank?
  end

  def name=(name)
    self.player = Player.find_or_create_by(name: name)
  end

  def format_json(options={})
    {id: self.id, name: self.player.name, score: self.value, time: self.occured_at}
  end

  ## score based on players
  def self.group_by_players(scores)
    response_players_scores = []
    if scores.present?
      players_scores = scores.group_by{|x| x[:player_id]}
      players_scores.each do |palyer_id, players_scores|
         player = {id: palyer_id, name: Player.find(palyer_id).name,  }
         player["scores"] = players_scores.each_with_object([]){|i,a| a << {id: i.id , score: i.value, time: i.occured_at}}
         response_players_scores << player
      end
      response_players_scores
    end
  end
end
