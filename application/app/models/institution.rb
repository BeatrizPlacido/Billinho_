class Institution < ApplicationRecord
  self.inheritance_column = :_type_disabled

  has_many :enrollments

  validates :name, presence: true, uniqueness: true
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "Deve conter apenas números" }
  validates :type, inclusion: { in: ["Universidade", "Escola", "Creche"] }
  validates :number, presence: true, numericality: { only_integer: true }
  validates :cep, presence: true, format: { with: /\A\d{5}-\d{3}\z/, message: "O CEP deve ser passado no formato 00000-000"}

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
