class Student < ApplicationRecord
  PERMITTED_PAYMENT_METHODS = %w[boleto card]

  validates :name, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true, format: {  with: /\d{11}/, message: "must contain only numbers" }
  validates :payment_method, presence: true, inclusion: { in: PERMITTED_PAYMENT_METHODS }
  validates :number, presence: true, numericality: { only_integer: true }
  validates :cep, presence: true, format: { with: /\d{5}-\d{3}/, message: "must be in the format 00000-000" }

  before_create :search_address

  private

  def search_address
    ZipcodeValidator.new(cep).search_address(self)
  end
end
