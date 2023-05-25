class RefutationsController < ApplicationController
  def new
    @agenda_board_id = params[:agenda_board_id].to_i
    @agenda_board_agenda = params[:agenda_board_agenda]
    if params[:type_of_opinion] == "argument"
      rebuttal_target_conclusion_id = params[:rebuttal_target_conclusion_id].to_i
      @rebuttal_target_conclusion = Conclusion.find(rebuttal_target_conclusion_id)
      @rebuttal_target_conclusion_index = params[:rebuttal_target_conclusion_index]
    else
      rebuttal_target_ref_conclusion_id = params[:rebuttal_target_ref_conclusion_id].to_i
      @rebuttal_target_ref_conclusion = RefConclusion.find(rebuttal_target_ref_conclusion_id)
      @rebuttal_target_ref_conclusion_index = params[:rebuttal_target_ref_conclusion_index]
    end

    @ref_conclusion = RefConclusion.new
    ref_reasons = @ref_conclusion.ref_reasons.build
    ref_reasons.ref_evidences.build
  end

  def create
    refutation = RefConclusion.new(refutation_params)
    if refutation.valid?
      flash[:notice] = "新規反論の作成に成功しました"
      refutation.save!
      redirect_to agenda_board_path(refutation.agenda_board_id)
    else
      flash[:notice] = "新規反論の作成に失敗しました｡"
      render :new
    end
  end

  def edit
    @agenda_board_agenda = params[:agenda_board_agenda]
    ref_conclusion_id = params[:edit_target_ref_conclusion_id].to_i
    @ref_conclusion = RefConclusion.find(ref_conclusion_id)

    if @ref_conclusion.conclusion_id
      @rebuttal_target_conclusion = Conclusion.find(@ref_conclusion.conclusion_id)
    else
      @rebuttal_target_ref_conclusion = RefConclusion.find(@ref_conclusion.parent_ref_conclusion_id)
    end
  end

  def update
    refutation_id = params[:edit_target_ref_conclusion_id].to_i
    refutation = RefConclusion.find(refutation_id)
    if refutation.update(refutation_params)
      flash[:notice] = "反論の編集に成功しました"
      redirect_to agenda_board_path(refutation.agenda_board_id)
    else
      flash[:notice] = "反論の編集に失敗しました"
      render "edit"
    end
  end

  private

  def refutation_params
    params.require(:ref_conclusion).permit(:agenda_board_id, :user_id, :conclusion_id, :parent_ref_conclusion_id, :ref_conclusion_summary, :ref_conclusion_detail,
      ref_reasons_attributes: [
        :id, :ref_reason_summary, :ref_reason_detail, :_destroy,
        ref_evidences_attributes: [:id, :ref_evidence_summary, :ref_evidence_detail, :_destroy],
      ])
  end
end
