class OpinionPositionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :find_opinion_position, only: [:create, :update]

  def create
    if @opinion_position
      update
    else
      create_new_opinion_position
    end
  end

  def update
    if @opinion_position.update(opinion_position_params)
      render_success('意見の位置を更新しました')
    else
      render_error(opinion_position.errors.full_messages)
    end
  end

  def index
    opinion_positions = OpinionPosition.all
    response_data = opinion_positions.map do |position|
      {
        argument_id: position.argument_id,
        refutation_id: position.refutation_id,
        left: position.left,
        top: position.top,
      }
    end

    render json: { opinion_positions: response_data }
  end

  private

  def opinion_position_params
    params.require(:opinion_position).permit(:argument_id, :refutation_id, :left, :top)
  end

  def find_opinion_position
    @opinion_position = OpinionPosition.find_by(argument_id: opinion_position_params[:argument_id]) ||
                        OpinionPosition.find_by(refutation_id: opinion_position_params[:refutation_id])
  end

  def create_new_opinion_position
    opinion_position = OpinionPosition.new(opinion_position_params)
    if opinion_position.save
      render_success('意見の位置を保存しました')
    else
      render_error(opinion_position.errors.full_messages)
    end
  end

  def render_success(message)
    render json: { message: message }
  end

  def render_error(errors)
    render json: { errors: errors }
  end
end
