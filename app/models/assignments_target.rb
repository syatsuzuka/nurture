class AssignmentsTarget < ApplicationRecord
  belongs_to :assignment, optional: true
  belongs_to :target, optional: true
end
