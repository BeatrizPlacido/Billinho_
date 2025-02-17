class Student < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true, format: {  with: /\d{11}/, message: "deve conter apenas números" }
  validates :gender, presence: true, inclusion: { in: ["M", "F"] }
  validates :payment_method, presence: true, inclusion: { in: ["Boleto", "Cartão"] }
  validates :number, presence: true, numericality: { only_integer: true }
  validates :cep, presence: true, format: { with: /\d{5}-\d{3}/, message: "deve ser passado no formato 00000-000"}

  before_create :search_address

  private

  def search_address
    ZipcodeValidator.new(cep).search_address(self)
  end
end
