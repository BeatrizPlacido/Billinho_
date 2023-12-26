class Bill < ApplicationRecord
  belongs_to :enrollment

  validates :invoice_value, presence: true
  validates :due_date, presence: true
  validates :status, presence: true, inclusion: { in: ["Aberta", "Atrasada", "Paga"] }

  before_validation :default_status

  private

  def default_status
    self.status ||= "Aberta"
  end
end
