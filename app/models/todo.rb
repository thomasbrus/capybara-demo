class Todo < ApplicationRecord
  validates :title, presence: true

  scope :finished, -> { where.not(finished_at: nil) }

  def finished?
    finished_at.present?
  end

  def finish!
    update!(finished_at: Time.current)
  end

  def unfinish!
    update!(finished_at: nil)
  end
end
