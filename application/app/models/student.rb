class Student < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true, format: {  with: /\d{11}/, message: "Deve conter apenas números" }
  validates :gender, presence: true, inclusion: { in: ["M", "F"] }
  validates :payment_method, presence: true, inclusion: { in: ["Boleto", "Cartão"] }
  validates :number, presence: true, numericality: { only_integer: true }
  validates :cep, presence: true, format: { with: /\d{5}-\d{3}/, message: "O CEP deve ser passado no formato 00000-000"}

  before_create :search_address

  private

  def search_address
    address = ViaCep::Address.new(cep)

    self.address = address.address
    self.neighborhood = address.neighborhood
    self.city = address.city
    self.state = address.state

  rescue ViaCep::ApiRequestError => _error
  end
end
