class IdentitySegment < ActiveRecord::Base
  belongs_to :identity
  belongs_to :segment_definition
end
