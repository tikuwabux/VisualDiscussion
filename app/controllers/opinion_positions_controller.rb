class OpinionPositionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    if OpinionPosition.find_by(argument_id: opinion_position_params[:argument_id]) or OpinionPosition.find_by(refutation_id: opinion_position_params[:refutation_id])
      update
      return
    end

    opinion_position = OpinionPosition.new(opinion_position_params)

    if opinion_position.save
      render json: { message: 'Opinion position saved successfully' }, status: :created
    else
      render json: { errors: opinion_position.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if opinion_position = OpinionPosition.find_by(argument_id: opinion_position_params[:argument_id])
    else
      opinion_position = OpinionPosition.find_by(refutation_id: opinion_position_params[:refutation_id])
    end

    if opinion_position.update(opinion_position_params)
      render json: { message: 'Opinion position updated successfully' }, status: :ok
    else
      render json: { errors: opinion_position.errors.full_messages }, status: :unprocessable_entity
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
end
