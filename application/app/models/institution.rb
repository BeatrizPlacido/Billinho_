class Institution < ApplicationRecord
  PERMITTED_TYPES = %i[university  elementary_school middle_school]

  self.inheritance_column = :_type_disabled

  has_many :enrollments

  validates :name, presence: true, uniqueness: true
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "must contain only numbers" }
  validates :type, inclusion: { in: PERMITTED_TYPES }
  validates :number, presence: true, numericality: { only_integer: true }
  validates :cep, presence: true, format: { with: /\A\d{5}-\d{3}\z/, message: "must be in the format 00000-000" }

  before_create :search_address

  private

  def search_address
    ZipcodeValidator.new(cep).search_address(self)
  end
end
