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
    invoice_value = total_course_price / quantity_of_bills
    today = Date.today
    current_day = today.day
    #mês seguinte
    if current_day > bill_due_date 
      month = 1
    #mês atual
    else 
      month = 0
    end
  
    quantity_of_bills.times do
      due_date = data_vencimento(today, month)
      due_date_format = due_date.strftime("#{bill_due_date}/%m/%Y")

      Bill.create!(
        invoice_value: invoice_value, 
        due_date: due_date_format,
        enrollment_id: id,
        status: "Aberta"
      )

      month += 1 
    end
  end 

  private

  def data_vencimento(today, month)
    today = Date.today
    current_day = today.day
    #mês seguinte
    if current_day > bill_due_date 
      due_date = today.next_month(month)
    #mês atual
    else 
      due_date = today.next_month(month)
    end
  end
end
