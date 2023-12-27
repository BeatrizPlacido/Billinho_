class Institution < ApplicationRecord
  self.inheritance_column = :_type_disabled
  has_many :enrollments

  validates :name, presence: true, uniqueness: true
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "Deve conter apenas números" }
  validates :type, inclusion: { in: ["Universidade", "Escola", "Creche"] }
end
