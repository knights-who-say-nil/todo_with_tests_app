require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do 
    it 'should switch complete to false if it began as true' do 
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it 'should switch complete to true if it began as false' do 
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do 
    it 'should switch favorite to false if it began as true' do 
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should switch favorite to true if it began as false' do 
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do 
    it 'should return true if deadline is in the past' do 
      task = Task.create(deadline: Time.now - 1.hour )
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if deadline is in the future' do 
      task = Task.create(deadline: Time.now + 1.hour )
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do 
    it 'should increase the priority of a task by 1' do 
      task = Task.create(priority: 5)
      task.increment_priority!
      expect(task.priority).to eq(6)
    end

    it 'should not increase the priority beyond 10' do 
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do 
    it 'should decrease the priority of a task by 1' do 
      task = Task.create(priority: 5)
      task.decrement_priority!
      expect(task.priority).to eq(4)
    end

    it 'should not decrease the priority beyond 1' do 
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do 
    it 'should push back the deadline by 1 hour' do 
      moment_in_time = Time.now
      task = Task.create(deadline: moment_in_time)
      task.snooze_hour!
      expect(task.deadline).to eq(moment_in_time + 1.hour)
    end
  end
end
