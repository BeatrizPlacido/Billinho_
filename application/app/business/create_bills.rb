class CreateBills
  def initialize(full_value, installments, due_day, id)
    @full_value = full_value
    @installments = installments
    @due_day = due_day
    @id = id
  end

  def perform
    create_bills
  end

  private

  attr_accessor :full_value, :installments, :due_day, :id

  def create_bills
    first_bill_due_date

    installments.times do
      Bill.create!(
        invoice_value: installment_value,
        due_date: installment_due_date(@index),
        enrollment_id: id,
        status: :waiting_payment
      )

      @index +=1
    end
  end

  def first_bill_due_date
    @index = Date.today.day >= due_day ? 1 : 0
  end

  def installment_value
    @installment_value ||= full_value / installments
  end

  def installment_due_date(index)
    date = Date.today.next_month(@index)

    return Date.new(date.year, date.month, due_day) if valid_date?(date)

    Date.new(date.year, date.month, -1)
  end

  def valid_date?(date)
    Date.valid_date?(date.strftime("%Y").to_i, date.strftime("%m").to_i, due_day)
  end
end
