# frozen_string_literal: true

# ブロック解除機能用のコントローラー
class Users::UnlocksController < Devise::UnlocksController
  # GET /users/unlock/new
  def new
    super
  end

  # POST /users/unlock
  def create
    super
  end

  # GET /users/unlock?unlock_token=abcdef
  def show
    super
  end

  protected

  # パスワードのロック解除指示を送信した後に使用する path
  def after_sending_unlock_instructions_path_for(resource)
    super(resource)
  end

  # リソースのロックを解除した後に使用する path
  def after_unlock_path_for(resource)
    super(resource)
  end
end
