class IdentitySegment < ActiveRecord::Base
  belongs_to :identity
  belongs_to :segment_definition

  def first_event
    nil
  end
end
