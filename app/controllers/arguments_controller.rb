class ArgumentsController < ApplicationController
  def new
    @agenda_board_id = params[:agenda_board_id].to_i
    @agenda_board_agenda = params[:agenda_board_agenda]

    @conclusion = Conclusion.new
    reasons = @conclusion.reasons.build
    reasons.evidences.build
  end

  def create
    argument = Conclusion.new(argument_params)
    if argument.valid?
      flash[:notice] = "新規主張の作成に成功しました"
      argument.save!
      redirect_to agenda_board_path(argument.agenda_board_id)
    else
      flash[:notice] = "新規主張の作成に失敗しました｡"
      render :new
    end
  end

  def edit
    @conclusion = Conclusion.find(params[:id])
    @agenda_board_agenda = AgendaBoard.find(@conclusion.agenda_board_id).agenda
  end

  def update
    argument = Conclusion.find(params[:id])
    if argument.update(argument_params)
      flash[:notice] = "主張の編集に成功しました"
      redirect_to agenda_board_path(argument.agenda_board_id)
    else
      flash[:notice] = "主張の編集に失敗しました"
      render "edit"
    end
  end

  def destroy
    argument = Conclusion.find(params[:id])
    argument.destroy
    flash[:notice] = "主張の削除に成功しました"
    redirect_to agenda_board_path(argument.agenda_board_id)
  end

  private

  def argument_params
    params.require(:conclusion).permit(:agenda_board_id, :user_id, :conclusion_summary, :conclusion_detail,
      reasons_attributes: [
        :id, :reason_summary, :reason_detail, :_destroy,
        evidences_attributes: [:id, :evidence_summary, :evidence_detail, :_destroy],
      ])
  end
end
