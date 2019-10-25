require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do 
    it 'should mark all tasks from the list as complete' do 
      list = List.create(name: "Grocery List")
      Task.create(list_id: list.id, complete: false)
      Task.create(list_id: list.id, complete: false)

      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do 
    it 'should snooze each task on a list' do 
      list = List.create(name: "find these moonrocks")

      moments_in_time = [Time.now, 36.minutes.from_now, 2.hours.ago]

      moments_in_time.each do |moment_in_time|
        Task.create(list_id: list.id, deadline: moment_in_time)
      end

      list.snooze_all_tasks!

      list.tasks.order(:id).each.with_index do |task, index|
        expect(task.deadline).to eq(moments_in_time[index] + 1.hour)
      end
    end
  end

  describe '#total_duration' do 
    it 'should return the added durations together' do 
      list = List.create(name: "tatoos I want to get")
      Task.create(list_id: list.id, duration: 13)
      Task.create(list_id: list.id, duration: 4)
      Task.create(list_id: list.id, duration: 80)

      expect(list.total_duration).to eq(97)
    end
  end

  describe '#incomplete_tasks' do 
    it 'should return a collection of the tasks on this list that are incomplete' do
      list = List.create(name: "bed maintainence")
      task_1 = Task.create(list_id: list.id, complete: true)
      task_2 = Task.create(list_id: list.id, complete: false)
      task_3 = Task.create(list_id: list.id, complete: false)
      task_4 = Task.create(list_id: list.id, complete: true)

      expect(list.incomplete_tasks).to match_array([task_3, task_2])
      expect(list.incomplete_tasks.count).to eq(2)

      list.incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
    end
  end

  describe '#favorite_tasks' do 
    it 'should return a collection of the tasks on this list that are favorited' do
      list = List.create(name: "car maintainence")
      task_1 = Task.create(list_id: list.id, favorite: true)
      task_2 = Task.create(list_id: list.id, favorite: false)
      task_3 = Task.create(list_id: list.id, favorite: true)
      task_4 = Task.create(list_id: list.id, favorite: false)

      testing_collection = list.favorite_tasks

      expect(testing_collection).to match_array([task_1, task_3])
      expect(testing_collection.count).to eq(2)

      testing_collection.each do |task|
        expect(task.favorite).to eq(true)
      end
    end
  end
end
