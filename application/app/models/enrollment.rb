class Enrollment < ApplicationRecord
  
  has_many :bills
  belongs_to :institution
  belongs_to :student

  validates :total_course_price, presence: true, numericality: { greater_than: 0 }
  validates :quantity_of_bills, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :bill_due_date, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
  validates :course_name, presence: true

  after_create :criar_faturas
  before_create :set_today

  def criar_faturas
    invoice_value = total_course_price / quantity_of_bills
    #Mês de início da cobrança
    if @current_day >= bill_due_date #Mês seguinte
      index = 1
    else #Mês atual
      index = 0
    end
  
    quantity_of_bills.times do
      due_date = data_vencimento(@today, index)

      #Validação de dia inexistente
      if bill_due_date >= 29 
        teste = validation(bill_due_date, index)
        due_date_format = due_date.strftime("#{teste}/%m/%Y")
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

  private

  def set_today
    @today = Date.today
    @current_day = @today.day
  end

  def data_vencimento(today, index)
    #mês seguinte
    if @current_day > bill_due_date 
      due_date = @today.next_month(index)
    #mês atual
    else 
      due_date = @today.next_month(index)
    end
  end

  def validation(bill_due_date, index)
    thirty_months = {
      30 => [4, 6, 9, 11]
    }

    if thirty_months.find { |chave, thirty_months| thirty_months.include?(index) }
      if bill_due_date == 31
        bill_due_date = 30
      end
    elsif index == 2
      if bill_due_date >= 29
        bill_due_date = 28
      end
    else
      bill_due_date = bill_due_date
    end
    return bill_due_date
  end
end
