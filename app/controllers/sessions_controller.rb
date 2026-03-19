class SessionsController < ApplicationController
  skip_before_action :logged_in_user, Only: [ :new, :create ]
  def new
  end

  def create
    user = User.find_by(nickname: params[:nickname])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to memories_path, notice: "ログインしました！"
    else
      flash.now[:alert] = "ニックネームまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました"
  end
end
