class Enrollment < ApplicationRecord
  has_many :bills
  belongs_to :institution
  belongs_to :student

  validates :total_course_price, presence: true, numericality: { greater_than: 0 }
  validates :quantity_of_bills, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :bill_due_date, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
  validates :course_name, presence: true

  after_create :criar_faturas

  def criar_faturas
    require 'date'
  
    invoice_value = total_course_price / quantity_of_bills
    today = Date.today
    current_day = today.strftime("%d").to_i
  
    if current_day > bill_due_date
      next_bill = today >> 1
      due_date = next_bill.strftime("#{bill_due_date}/%m/%Y")
      month = 1
    else
      due_date = today.strftime("#{bill_due_date}/%m/%Y")
      month = 0
    end
  
    bills_to_create = quantity_of_bills.to_i.abs

    while bills_to_create > 0 
      next_bill = today >> month
      due_date = next_bill.strftime("#{bill_due_date}/%m/%Y")
      Bill.create!(invoice_value:invoice_value, due_date:due_date)
      puts bills_to_create, due_date
      bills_to_create -= 1
      month += 1
    end
  end 
end
