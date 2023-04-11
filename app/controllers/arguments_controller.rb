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

    binding.pry

    if argument.valid?
      flash[:notice] = "新規主張の作成に成功しました"
      argument.save!
    else
      flash[:notice] = "新規主張の作成に失敗しました｡"
      render :new
    end
  end

  private

  def argument_params
    params.require(:conclusion).permit(:agenda_board_id, :conclusion_summary, :conclusion_detail,
      reasons_attributes: [:reason_summary, :reason_detail,
        evidences_attributes: [:evidence_summary, :evidence_detail]
      ]
    )
  end
end
