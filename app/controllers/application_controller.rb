class ApplicationController < ActionController::Base
  before_action :prepare_agenda_board_search_form

  def prepare_agenda_board_search_form
    @search = AgendaBoard.ransack(params[:q])
  end
end
