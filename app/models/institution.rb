class Institution < ApplicationRecord
  has_many :enrollments

  validates :name, presence: true, uniqueness: true
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "Deve conter apenas números" }
  validates :type, inclusion: { in: ["Universidade", "Escola", "Creche"] }
end
