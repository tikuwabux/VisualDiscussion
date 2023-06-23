class OpinionConnectionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  before_action :find_opinion_connection, only: [:create, :update, :destroy]

  def create
    if @opinion_connection
      update
      return
    end

    opinion_connection = OpinionConnection.new(opinion_connection_params)
    if opinion_connection.save
      render_success('意見間の接続線情報を保存しました')
    else
      render_error("意見間の接続線情報を保存できませんでした")
    end
  end

  def update
    if @opinion_connection.update(opinion_connection_params)
      render_success("意見間の接続線情報を更新しました")
    else
      render_error("意見間の接続線情報を更新できませんでした")
    end
  end

  def destroy
    if @opinion_connection.destroy
      render_success("意見間の接続線情報を削除しました")
    else
      render_error("意見間の接続線情報を削除できませんでした")
    end
  end

  def index
    opinion_connections = OpinionConnection.all
    if opinion_connections.present?
      response_data = opinion_connections.map do |opinion_connection|
        {
          source_id: opinion_connection.source_id,
          target_id: opinion_connection.target_id,
        }
      end
      render json: { opinion_connections: response_data }
    else
      render_error('意見間の接続線情報を取得できませんでした')
    end
  end

  private

  def opinion_connection_params
    params.require(:opinion_connection).permit(:source_id, :target_id)
  end

  def find_opinion_connection
    @opinion_connection = OpinionConnection.find_by(source_id: opinion_connection_params[:source_id])
  end

  def render_success(success_message)
    render json: { success_message: success_message }
  end

  def render_error(error_message)
    render json: { error_message: error_message }, status: 500
  end
end
