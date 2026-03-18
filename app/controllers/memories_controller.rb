class MemoriesController < ApplicationController
  before_action :logged_in_user
  def index
    @memories = current_user.memories.where(status: 0).order(created_at: :desc)
    @memory = current_user.memories.build
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
  end

  def destroy
  end

  private

  def memory_params
    params.require(:memory).permit(:content)
  end
end
