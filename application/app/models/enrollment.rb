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
    require 'time', 'date'

    invoice_value = total_course_price / quantity_of_bills
    current_day = Time.now
    today = current_day.strftime("%d").to_i

    if today <= bill_due_date
      next_mounth = current_day >> 1
      due_date = next_mounth.strftime("#{bill_due_date}/%m/%Y").to_date
    else
      due_date = current_day.strftime("#{bill_due_date}/%m/%Y").to_date
    
    quantity_of_bills.times do
      Fatura.create!(invoice_value: invoice_value, due_date: due_date, enrollment_id: id, status: 'Aberta')
     
  end 
end
