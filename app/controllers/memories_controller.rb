class MemoriesController < ApplicationController
  before_action :logged_in_user
  def index
    @memories = current_user.memories.where(status: 0).order(created_at: :desc)
    @memory = current_user.memories.build
  end

  def history
    @history_memories = current_user.memories.where(status: 1).order(updated_at: :desc)
  end

  def create
    @memory = current_user.memories.build(memory_params)
    if @memory.save
      redirect_to memories_path, notice: "「あとで」リストに追加しました！"
    else
      @memories = current_user.memories.where(status: 0).order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @memory = current_user.memories.find(params[:id])
    if @memory.update(status: 1)
      redirect_to memories_path, notice: "解決済みにしました！"
    else
      redirect_to memories_path, alert: "更新に失敗しました"
    end
  end

  def destroy
    @memory = current_user.memories.find(params[:id])
    @memory.destroy
    redirect_to history_memories_path, notice: "削除しました", status: :see_other
  end

  private

  def memory_params
    params.require(:memory).permit(:content)
  end
end
