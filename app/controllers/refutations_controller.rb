class RefutationsController < ApplicationController
  def new
    @agenda_board_id = params[:agenda_board_id].to_i
    @agenda_board_agenda = params[:agenda_board_agenda]
    rebuttal_target_conclusion_id = params[:rebuttal_target_conclusion_id].to_i
    @rebuttal_target_conclusion = Conclusion.find(rebuttal_target_conclusion_id)
    @rebuttal_target_conclusion_index = params[:rebuttal_target_conclusion_index]

    @ref_conclusion = RefConclusion.new
    ref_reasons = @ref_conclusion.ref_reasons.build
    ref_reasons.ref_evidences.build
  end


  end  def create
    refutation = RefConclusion.new(refutation_params)
    if refutation.valid?
      flash[:notice] = "新規反論の作成に成功しました"
      refutation.save!
      redirect_to agenda_board_path(refutation.agenda_board_id)
    else
      flash[:notice] = "新規反論の作成に失敗しました｡"
      render :new
    end

  private

  def refutation_params
    params.require(:ref_conclusion).permit(:agenda_board_id, :ref_conclusion_summary, :ref_conclusion_detail,
      ref_reasons_attributes: [:id, :ref_reason_summary, :ref_reason_detail, :_destroy,
        ref_evidences_attributes: [:id, :ref_evidence_summary, :ref_evidence_detail, :_destroy]
      ]
    )
  end
end
