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
    initial_bill(@current_day, @index)
    quantity_of_bills.times do
      validation(@index, @today, @due_date_format)

      Bill.create!(
        invoice_value: invoice_value,
        due_date: @due_date_format,
        enrollment_id: id,
        status: "Aberta"
      )

      @index += 1
    end
  end

  private

  def set_today
    @today = Date.today
    @current_day = @today.day
    @index = 2
    @due_date_format = Date.new()
  end

  def initial_bill(current_day, index)
    if @current_day >= bill_due_date
      @index = 1
    else
      @index = 0
    end
    return @index
  end

  def validation(index, today, due_date_format)
    due_date = @today.next_month(@index)
    bill_month = due_date.strftime("%m").to_i
    bill_year = due_date.strftime("%Y").to_i

    validation = Date.valid_date?(bill_year, bill_month, bill_due_date)

    if validation == false
      @due_date_format = Date.new(bill_year,bill_month,-1)
    else
      @due_date_format = Date.new(bill_year, bill_month, bill_due_date)
    end
  end
end