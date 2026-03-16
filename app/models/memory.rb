class Memory < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :status, presence: true
  validate :check_memory_limit, on: :create

  private
  def check_memory_limit
    # userが紐づいていない場合（バリデーションエラー防止）
    return unless user

    # 未解決の(status :0)が30件以上の場合
    if status == 0 && user.memories.where(status: 0).count >= 30
       errors.add(:base, "未解決のメモが30件に達しています。調べて解決してから追加しましょう！")
    # 履歴(status: 1)が100件以上ある場合
    elsif status == 1 && user.memories.where(status: 1).count >= 100
       errors.add(:base, "履歴が100件に達しています。不要なものを整理してください。")
    end
  end
end
