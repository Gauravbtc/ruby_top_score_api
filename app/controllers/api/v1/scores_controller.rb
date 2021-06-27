class Api::V1::ScoresController < ApplicationController
  before_action :set_score, only: [:show, :destroy]
  before_action :set_list_params, only: [:index]

  DEFAULT_PAGE = 1
  DEFAULT_PAGE_SIZE = 10

  def index
    @scores = Score.by_players(@players)
                   .after_time(@after)
                   .before_time(@before)
    players_scores = Score.group_by_players(@scores)
    if players_scores.present?
      players_pagination = Kaminari.paginate_array(players_scores, total_count:  players_scores.size).page(@page).per(10)
      json_response({ data: players_pagination, page: @page, total_count: players_pagination.total_count, success: true})
    else
      json_response({ message: "Score data is not available", data: [], page: 0, total_count: 0,success: true })
    end
  end


  def create
    score = Score.create!(score_params)
    json_response({ message: "Score Created..", status_code: 200, data: score.format_json, success: true})
  end

  def show
    json_response({ message: "Score details", status_code: 200, data: @score.format_json, success: true})
  end

  def destroy
    @score.destroy
    json_response({ message: "Score Deleted", status_code: 200, data: {}, success: true})
  end


  private
    def score_params
      params.require(:score).permit(:name, :score, :time)
    end

    def set_score
      @score = Score.find(params[:id])
    end

    def set_list_params
      @page = params[:page].present? ? params[:page].to_i : DEFAULT_PAGE
      @size = params[:size].present? ? params[:size].to_i : DEFAULT_PAGE_SIZE
      @players = params[:players].present? ? params[:players].split(',').map(&:strip) : nil
      @before = params[:before].present? ? DateTime.iso8601(params[:before]) : nil
      @after = params[:after].present? ? DateTime.iso8601(params[:after]) : nil
  end
end