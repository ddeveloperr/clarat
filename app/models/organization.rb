class Organization < ActiveRecord::Base
  has_paper_trail

  # Associtations
  has_many :offers, through: :organizations
  has_many :locations
  has_many :offers, through: :locations
  has_many :websites, as: :linkable, inverse_of: :linkable

  # Enumerization
  extend Enumerize
  enumerize :legal_form, in: %w[ev ggmbh gag foundation gug kdor gmbh ag ug]
  enumerize :classification, in: %w[welfare other]

  # Validations
  validates :name, length: { maximum: 80 }, presence: true
  validates :description, length: { maximum: 400 }, presence: true
  validates :legal_form, presence: true
  validates :classification, presence: true
  validates :founded, length: { is: 4 }
end