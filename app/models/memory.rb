class Memory < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :status, presence: true
  validates :check_memory_limit, on: :create

  private
  def check_memory_limit
    # 未解決の(status :0)が30件以上の場合
    if states == 0 && user.memories.where(status: 0).count >= 30
       errors.add(:base, "未解決のメモが30件に達しています。調べて解決してから追加しましょう！")
    # 履歴(status: 1)が100件以上ある場合
    elsif states == 1 && user.memories.where(status: 1).count >= 100
       errors.add(:base, "履歴が100件に達しています。不要なものを整理してください。")
    end
  end
end
