class CreateBills
  attr_accessor :full_value, :installments, :due_day, :enrollment_id

  def initialize(full_value, installments, due_day, enrollment_id)
    @full_value = full_value
    @installments = installments
    @due_day = due_day
    @enrollment_id = enrollment_id
  end

  def perform
    validate!

    ActiveRecord::Base.transaction do
      create_bills
    end
  end

  private

  def validate!
    raise ArgumentError, 'full_value must be valid' if full_value <= 0
    raise ArgumentError, 'installments must be valid' if installments <= 0
    raise ArgumentError, 'due_day must be valid' if due_day < 1 || due_day > 31
  end

  def create_bills
    first_installment_due_date

    installments.times do
      Bill.create!(
        invoice_value: installment_value,
        due_date: installment_due_date(@index),
        enrollment_id: enrollment_id,
        status: "Aberta"
      )

      @index +=1
    end
  end

  def first_installment_due_date
    @index = Date.today.day >= due_day ? 1 : 0
  end

  def installment_value
    full_value / installments
  end

  def installment_due_date(index)
    date = Date.today.next_month(@index)

    if Date.valid_date?(date.strftime("%Y").to_i, date.strftime("%m").to_i, due_day)
      due_date = Date.new(date.year, date.month, due_day)
    else
      due_date = Date.new(date.year, date.month,-1)
    end

    due_date
  end
end
