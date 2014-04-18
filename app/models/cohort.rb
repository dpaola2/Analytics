class Cohort < ActiveRecord::Base
  belongs_to :segment_definition
  
  def results
    (0..5).collect do |weeks_ago|
      week = Date.today.beginning_of_week - weeks_ago.weeks
      member_count = self.segment_definition.members_on_week(week).count

      { :week => week.beginning_of_week, :count => member_count}
    end
  end
end
