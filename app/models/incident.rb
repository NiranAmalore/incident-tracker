class Incident < ApplicationRecord
  belongs_to :user

  enum :status, { open: 0, in_progress: 1, resolved: 2, closed:3 }
  enum :severity, { low: 0, medium: 1, high: 2, critical:3 }

  validates :title, presence: true
end
