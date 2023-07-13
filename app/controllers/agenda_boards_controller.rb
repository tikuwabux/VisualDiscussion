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
    @ref_conclusions = @agenda_board.ref_conclusions
  end

  def index_created_by_current_user
    @user_created_agenda_boards = AgendaBoard.where(user_id: current_user.id).order(created_at: :desc)
  end

  def index_with_opinion_posted_by_current_user
    agenda_board_ids = current_user.conclusions.pluck(:agenda_board_id) | current_user.ref_conclusions.pluck(:agenda_board_id)
    @agenda_boards = AgendaBoard.where(id: agenda_board_ids).order(created_at: :desc)
  end

  def index_searched_by_category
    @search_category = params[:q][:category_cont]
    search = AgendaBoard.ransack(params[:q])
    @search_result_agenda_boards = search.result.order(created_at: :desc)
  end

  def index_searched_by_agenda
    @input_content = params[:q][:agenda_cont]
    keywords = @input_content.split(/[\p{blank}\s]+/)
    grouping_array = keywords.reduce([]){ |array, word| array << { agenda_cont: word } }
    search = AgendaBoard.ransack({ combinator: 'and', groupings: grouping_array })
    @search_result_agenda_boards = search.result.order(created_at: :desc)
  end

  def edit
    @agenda_board = AgendaBoard.find(params[:id])
  end

  def update
    agenda_board = AgendaBoard.find(params[:id])
    if agenda_board.update(agenda_board_params)
      flash[:notice] = "議題ボードの編集に成功しました"
      redirect_to current_user_created_agenda_boards_path
    else
      flash[:notice] = "議題ボードの編集に失敗しました"
      render "edit"
    end
  end

  def destroy
    agenda_board = AgendaBoard.find(params[:id])
    agenda_board.destroy
    flash[:notice] = "議題ボードの削除に成功しました"
    redirect_to current_user_created_agenda_boards_path
  end

  private

  def agenda_board_params
    params.require(:agenda_board).permit(:user_id, :agenda, :category)
  end
end
