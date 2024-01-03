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

    #Mês de início da cobrança
    if current_day >= bill_due_date #Mês seguinte
      index = 1
    else #Mês atual
      index = 0
    end
  
    quantity_of_bills.times do
      due_date = today.next_month(index)
      bill_month = due_date.strftime("%m").to_i
      bill_year = due_date.strftime("%Y").to_i
      
      validation = Date.valid_date?(2023, bill_month, bill_due_date)

      if validation == false
        due_date_format = Date.new(bill_year,bill_month,-1)
      else
        due_date_format = Date.new(bill_year, bill_month, bill_due_date)
      end

      Bill.create!(
        invoice_value: invoice_value, 
        due_date: due_date_format,
        enrollment_id: id,
        status: "Aberta"
      )

      index += 1
    end
  end 
end