class ArgumentsController < ApplicationController
  def new
    @agenda_board_id = params[:agenda_board_id].to_i
    @agenda_board_agenda = params[:agenda_board_agenda]

    @conclusion = Conclusion.new
    reasons = @conclusion.reasons.build
    reasons.evidences.build
  end

  def create
    @conclusion = Conclusion.new(argument_params)

    if @conclusion.valid?
      flash[:notice] = "新規主張の作成に成功しました"
      @conclusion.save!
      redirect_to agenda_board_path(@conclusion.agenda_board_id)
    else
      flash[:error_full_messages] = @conclusion.errors.full_messages.reverse
      @agenda_board_id = params[:conclusion][:agenda_board_id].to_i
      @agenda_board_agenda = AgendaBoard.find(@agenda_board_id).agenda
      render :new
    end
  end

  def edit
    @conclusion = Conclusion.find(params[:id])
    @agenda_board_agenda = AgendaBoard.find(@conclusion.agenda_board_id).agenda
  end

  def update
    @conclusion = Conclusion.find(params[:id])

    if @conclusion.update(argument_params)
      flash[:notice] = "主張の編集に成功しました"
      redirect_to agenda_board_path(@conclusion.agenda_board_id)
    else
      flash[:error_full_messages] = @conclusion.errors.full_messages.reverse
      @agenda_board_agenda = AgendaBoard.find(@conclusion.agenda_board_id).agenda
      render :edit
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
