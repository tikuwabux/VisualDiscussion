class OpinionConnectionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    if OpinionConnection.find_by(source_id: opinion_connection_params[:source_id])
      update
      return
    end

    opinion_connection = OpinionConnection.new(opinion_connection_params)
    if opinion_connection.save
      render json: { success_message: "意見間の接続線情報を保存しました" }
    else
      render json: { error_message: "意見間の接続線情報を保存できませんでした" }, status: :unprocessable_entity
    end
  end

  def update
    opinion_connection = OpinionConnection.find_by(source_id: opinion_connection_params[:source_id])

    if opinion_connection.update(opinion_connection_params)
      render json: { success_message: "意見間の接続線情報を更新しました" }
    else
      render json: { error_message: "意見間の接続線情報を更新できませんでした" }, status: :unprocessable_entity
    end
  end

  def destroy
    opinion_connection = OpinionConnection.find_by(opinion_connection_params)
    if opinion_connection
      opinion_connection.destroy
      render json: { success_message: "意見間の接続線情報を削除しました" }
    else
      render json: { error_message: "意見間の接続線情報を削除できませんでした" }, status: :not_found
    end
  end

  def index
    opinion_connections = OpinionConnection.all
    if opinion_connections
      response_data = opinion_connections.map do |opinion_connection|
        {
          source_id: opinion_connection.source_id,
          target_id: opinion_connection.target_id,
        }
      end
      render json: { opinion_connections: response_data }
    else
      render json: { error_message: '意見間の接続線情報を取得できませんでした' }, status: :not_found
    end
  end

  private

  def opinion_connection_params
    params.require(:opinion_connection).permit(:source_id, :target_id)
  end
end
