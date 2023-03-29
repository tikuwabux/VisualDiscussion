# frozen_string_literal: true

# サインアップ(パスワード登録),パスワード編集､等のコントローラー
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /users/sign_up
  def new
    super
  end

  # POST /users
  def create
    super
  end

  # GET /users/edit
  def edit
    super
  end

  # PUT /users
  def update
    super
  end

  # DELETE /users
  def destroy
    super
  end

  # GET /users/cancel
  # 通常はサインイン後に
  # 期限切れになるセッションデータを強制的に今すぐ期限切れにします。
  # これは、ユーザーがすべての OAuth セッションデータを削除して、
  # 途中で oauth サインイン/アップをキャンセルしたい場合に便利です。
  def cancel
    super
  end

  protected

  # サインアップ時用のメソッド
  # 許可するための追加のパラメータがある場合は、sanitizer に追加してください
  # :name(ユーザー名)を追加した
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :name])
  end

  # アカウント編集時用のメソッド
  # 許可するための追加のパラメータがある場合は、sanitizer に追加してください
  # :name(ユーザー名)を追加した
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :name])
  end

  # サインアップ後に使用する path
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # アクティブでないアカウントのサインアップ後に使用する path
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
