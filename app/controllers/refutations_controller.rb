class RefutationsController < ApplicationController
  def new
    @agenda_board_id = params[:agenda_board_id].to_i
    @agenda_board_agenda = params[:agenda_board_agenda]

    if params[:type_of_opinion] == "argument"
      rebuttal_target_conclusion_id = params[:rebuttal_target_conclusion_id].to_i
      @rebuttal_target_conclusion = Conclusion.find(rebuttal_target_conclusion_id)
    else
      rebuttal_target_ref_conclusion_id = params[:rebuttal_target_ref_conclusion_id].to_i
      @rebuttal_target_ref_conclusion = RefConclusion.find(rebuttal_target_ref_conclusion_id)
    end

    @ref_conclusion = RefConclusion.new
    ref_reasons = @ref_conclusion.ref_reasons.build
    ref_reasons.ref_evidences.build
  end

  def create
    @ref_conclusion = RefConclusion.new(refutation_params)

    if @ref_conclusion.save
      flash[:notice] = "新規反論の作成に成功しました"
      redirect_to agenda_board_path(@ref_conclusion.agenda_board_id)
    else
      flash[:error_full_messages] = @ref_conclusion.errors.full_messages.reverse
      set_additional_variables
      render :new
    end
  end

  def edit
    @ref_conclusion = RefConclusion.find(params[:id])
    @agenda_board_agenda = AgendaBoard.find(@ref_conclusion.agenda_board_id).agenda

    if @ref_conclusion.conclusion_id
      @rebuttal_target_conclusion = Conclusion.find(@ref_conclusion.conclusion_id)
    else
      @rebuttal_target_ref_conclusion = RefConclusion.find(@ref_conclusion.parent_ref_conclusion_id)
    end
  end

  def update
    refutation = RefConclusion.find(params[:id])

    if refutation.update(refutation_params)
      flash[:notice] = "反論の編集に成功しました"
      redirect_to agenda_board_path(refutation.agenda_board_id)
    else
      flash[:notice] = "反論の編集に失敗しました"
      render "edit"
    end
  end

  def destroy
    refutation = RefConclusion.find(params[:id])
    refutation.destroy
    flash[:notice] = "反論の削除に成功しました"
    redirect_to agenda_board_path(refutation.agenda_board_id)
  end

  private

  def refutation_params
    params.require(:ref_conclusion).permit(
      :agenda_board_id, :user_id, :conclusion_id, :parent_ref_conclusion_id,
      :ref_conclusion_summary, :ref_conclusion_detail,
      ref_reasons_attributes: [
        :id, :ref_reason_summary, :ref_reason_detail, :_destroy,
        ref_evidences_attributes: [:id, :ref_evidence_summary, :ref_evidence_detail, :_destroy],
      ]
    )
  end

  def set_additional_variables
    @agenda_board_id = refutation_params[:agenda_board_id]
    @agenda_board_agenda = AgendaBoard.find(@agenda_board_id).agenda

    if refutation_params[:conclusion_id]
      @rebuttal_target_conclusion = Conclusion.find(refutation_params[:conclusion_id])
    else
      @rebuttal_target_ref_conclusion = RefConclusion.find(refutation_params[:parent_ref_conclusion_id])
    end
  end
end
