class Users::ProfileController < ApplicationController
  def show; end

  def edit; end

  def update
    if current_user.update(profile_params)
      redirect_to users_profile_path, notice: "プロフィール情報が変更されました。"
    else
      flash.now[:alert] = "プロフィール情報の変更に失敗しました。"
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:image, :name, :introduction)
  end
end
