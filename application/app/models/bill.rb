class Bill < ApplicationRecord
  include AASM

  PERMITTED_STATUSES = %w[waiting_payment pending paid]

  belongs_to :enrollment

  validates :invoice_value, presence: true, numericality: { greater_than: 0 }
  validates :due_date, presence: true
  validates :status, presence: true, inclusion: { in: PERMITTED_STATUSES }

  aasm column: :status, whiny_transitions: true do
    state :waiting_payment, initial: true
    state :pending
    state :paid

    event :mark_as_pending, if: :overdue? do
      transitions from: :waiting, to: :pending
    end

    event :mark_as_paid do
      transitions from: [:waiting, :pending], to: :paid
    end
  end

  def overdue?
    due_date.past?
  end
end
