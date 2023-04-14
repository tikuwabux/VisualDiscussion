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

  private

  def argument_params
    params.require(:conclusion).permit(:agenda_board_id, :conclusion_summary, :conclusion_detail,
      reasons_attributes: [
        :id, :reason_summary, :reason_detail, :_destroy,
        evidences_attributes: [:id, :evidence_summary, :evidence_detail, :_destroy],
      ])
  end
end
