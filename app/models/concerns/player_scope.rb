module PlayerScope
  extend ActiveSupport::Concern
  included do
    def player_history
      player = {}
      player[:id] = self.id
      player[:name] = self.name
      # 1 Top Score
      player[:top_score] = top_score
      # 2 Worst Score
      player[:low_score] =  low_score
      # 3 Avg Score
      player[:average_score] = scores.average(:value).to_i
      # 4 history
      player[:history] = history
      player
    end

    def top_score
      score = scores.sort_by {|x| -x[:value]}
      {score: score[0][:value], time: score[0][:occured_at]}
    end

    def low_score
      score = scores.sort_by {|x| x[:value]}
      {score: score[0][:value], time: score[0][:time]}
    end

    def history
      scores.pluck(:value, :occured_at).map { |v, t| { score: v, time: t } }
    end
  end
end