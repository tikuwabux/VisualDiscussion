# frozen_string_literal: true

# パスワードを忘れた方は。。。の場合用のコントローラー
class Users::PasswordsController < Devise::PasswordsController
  # GET /users/password/new
  def new
    super
  end

  # POST /users/password
  def create
    super
  end

  # GET /users/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /users/password
  def update
    super
  end

  protected

  def after_resetting_password_path_for(resource)
    super(resource)
  end

  # リセットパスワードの指示を送信した後に使用する path
  def after_sending_reset_password_instructions_path_for(resource_name)
    super(resource_name)
  end
end
