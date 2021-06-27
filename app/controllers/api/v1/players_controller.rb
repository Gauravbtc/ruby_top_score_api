class Api::V1::PlayersController < ApplicationController
  before_action :set_player, only: [:history]
  before_action :set_list_params, only: [:index]


  def history
    json_response({ message: "Player details", status_code: 200, data: @player.player_history})
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end
end