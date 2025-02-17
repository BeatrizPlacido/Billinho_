class Bill < ApplicationRecord
  PERMITTED_STATUSES = %i[waiting_payment pending paid]

  belongs_to :enrollment

  validates :invoice_value, presence: true
  validates :due_date, presence: true
  validates :status, presence: true, inclusion: { in: PERMITTED_STATUSES }

  before_validation :default_status

  private

  def default_status
    status = :waiting_payment
  end
end
