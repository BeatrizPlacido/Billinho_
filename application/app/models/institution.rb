class Institution < ApplicationRecord
  self.inheritance_column = :_type_disabled

  has_many :enrollments

  validates :name, presence: true, uniqueness: true
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "deve conter apenas números" }
  validates :type, inclusion: { in: ["Universidade", "Escola", "Creche"] }
  validates :number, presence: true, numericality: { only_integer: true }
  validates :cep, presence: true, format: { with: /\A\d{5}-\d{3}\z/, message: "deve ser passado no formato 00000-000"}

  before_create :search_address

  private

  def search_address
    ZipcodeValidator.new(cep).search_address(self)
  end
end
