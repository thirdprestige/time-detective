require 'spec_helper'

describe Project do
  subject { FactoryGirl.create(:project) }
  let(:activity) { FactoryGirl.create(:activity, project: subject) }

  describe Project::Activity do
    it 'should only allow a worker within a given account' do
      -> do
        user = FactoryGirl.create(:user)
        user.accountings.update_all account_id: FactoryGirl.create(:account).id

        subject.activities.create! do |activity|
          activity.worker = user
        end
      end.should raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe Project::TimeEntry do
    context 'overlapping activities' do
      before do
        activity
      end

      it 'should map activities within 4 hours' do
        -> do
          subject.time_entries.create! do |time_entry|
            time_entry.created_at = activity.created_at
            time_entry.worker_id  = activity.worker_id
          end
        end.should change(subject.activities.potentially_unbilled_work, :count).from(1).to(0)
      end

      it 'should ignore activities outside the window' do
        -> do
          subject.time_entries.create! do |time_entry|
            time_entry.created_at = 3.days.ago
            time_entry.worker_id  = activity.worker_id
          end
        end.should_not change(subject.activities.potentially_unbilled_work, :count)
      end

      it 'should ignore activities by other workers' do
        user = FactoryGirl.create(:user)
        user.accountings.update_all account_id: FactoryGirl.create(:account).id

        -> do
          subject.time_entries.create! do |time_entry|
            time_entry.created_at = activity.created_at
            time_entry.worker_id  = user.id
          end
        end.should_not change(subject.activities.potentially_unbilled_work, :count)
      end
    end
  end
end
