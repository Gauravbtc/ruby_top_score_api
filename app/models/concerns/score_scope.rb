module ScoreScope
  extend ActiveSupport::Concern
  included do
    scope :by_players, ->(players) {joins(:player).where("players.name IN (?)", players) if players.present?}
    scope :before_time, lambda {|args| where("occured_at <= ?", args)  unless args.nil? }
    scope :after_time, lambda {|args| where("occured_at >= ?", args)  unless args.nil? }
  end
end