class Enrollment < ApplicationRecord
  has_many :bills

  belongs_to :institution
  belongs_to :student

  validates :total_course_price, presence: true, numericality: { greater_than: 0 }
  validates :quantity_of_bills, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :bill_due_date, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
  validates :course_name, presence: true

  after_create :create_bills

  private

  def create_bills
    create_bills_service = CreateBills.new(total_course_price, quantity_of_bills, bill_due_date, id)
    create_bills_service.perform
  end
end