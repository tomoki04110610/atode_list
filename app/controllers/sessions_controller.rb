class SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: [ :new, :create ], raise: false
  def new
    if logged_in?
      redirect_to memories_path
    end
  end

  def create
    user = User.find_by(nickname: params[:nickname])

    if user && user.authenticate(params[:password])
      log_in user
      redirect_to memories_path, notice: "ログインしました！"
    else
      flash.now[:alert] = "ニックネームまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, notice: "ログアウトしました", status: :see_other
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
