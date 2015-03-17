require 'rails_helper'

RSpec.describe "Todo Rake", :type => :task do

  context "todo:delete_items" do

    before do
      # Freeze time as task is time-sensitive
      Timecop.freeze(Time.now)
    end

    after { Timecop.return }

    it "leaves items of age 7 days or younger" do
      not_overdue = create(:item, created_at: 0.days.ago)
      expect { invoke_task }.not_to change { Item.count }
    end

    it "deletes item of age more than 7 days" do
      overdue = create(:item, created_at: (8.days).ago)
      expect { invoke_task }.to change { Item.count }.from(1).to(0)
    end

    it "ends gracefully when no items exist" do
      expect { invoke_task }.not_to raise_error
    end

    private

    def invoke_task
      task = Rake::Task["todo:delete_items"]
      # Ensure task is re-enabled, as rake tasks by default are disabled
      # after running once within a process http://pivotallabs.com/how-i-test-rake-tasks/
      task.reenable
      task.invoke
    end

  end

end
