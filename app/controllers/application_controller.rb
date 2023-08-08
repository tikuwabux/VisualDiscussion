class ApplicationController < ActionController::Base
  before_action :prepare_agenda_board_search_form

  def prepare_agenda_board_search_form
    @search = AgendaBoard.ransack(params[:q])
  end

  def authenticate_user
    if current_user == nil
      flash[:alert] = "ログインもしくはサインアップが必要です"
      redirect_to sign_in_path
    end
  end
end
