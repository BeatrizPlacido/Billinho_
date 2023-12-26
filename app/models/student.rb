class Student < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :gender, presence: true, inclusion: { in: ["M", "F"] }
  validates :payment_method, presence: true, inclusion: { in: ["Boleto", "Cartão"] }
end
