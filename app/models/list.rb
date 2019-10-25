class List < ApplicationRecord
  has_many :tasks

  def complete_all_tasks!
    tasks.update_all(complete: true)
  end

  def snooze_all_tasks!
    tasks.each(&:snooze_hour!)
  end

  def total_duration
    tasks.sum(:duration)
  end

  def incomplete_tasks
    tasks.where(complete: false) 
  end

  def favorite_tasks
    tasks.where(favorite: true)
  end
end
