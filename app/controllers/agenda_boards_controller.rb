class AgendaBoardsController < ApplicationController
  def new
    @agenda_board = AgendaBoard.new
  end

  def create
    @agenda_board = AgendaBoard.new(agenda_board_params)
    if @agenda_board.save
      flash[:notice] = "｢#{@agenda_board.agenda}｣のボード作成に成功しました"
      redirect_to agenda_board_path(@agenda_board.id)
    else
      flash[:notice] = "｢#{@agenda_board.agenda}｣のボード作成に失敗しました"
      render "new"
    end
  end

  def show
    @agenda_board = AgendaBoard.find(params[:id])
    @conclusions = @agenda_board.conclusions
  end

  def index
    @user_created_agenda_boards = AgendaBoard.where(user_id: current_user.id).order(created_at: :desc)
  end

  private

  def agenda_board_params
    params.require(:agenda_board).permit(:user_id, :agenda, :category)
  end
end
