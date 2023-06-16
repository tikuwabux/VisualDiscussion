class OpinionPositionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    if OpinionPosition.find_by(argument_id: argument_position_params[:argument_id])
      update
      return
    end

    argument_position = OpinionPosition.new(argument_position_params)

    if argument_position.save
      render json: { message: 'Argument position saved successfully' }, status: :created
    else
      render json: { errors: argument_position.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    argument_position = OpinionPosition.find_by(argument_id: argument_position_params[:argument_id])

    if argument_position.update(argument_position_params)
      render json: { message: 'Argument position updated successfully' }, status: :ok
    else
      render json: { errors: argument_position.errors.full_messages }, status: :unprocessable_entity
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

    render json: { argument_positions: response_data }
  end

  private

  def argument_position_params
    params.require(:argument_position).permit(:argument_id, :refutation_id, :left, :top)
  end
end
