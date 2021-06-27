class Player < ApplicationRecord
  ## Relastions
  has_many :scores, inverse_of: :player, dependent: :destroy

  ## scopes
  include PlayerScope

  ## Validations
  validates :name, presence: true, uniqueness: {message: 'Player allready exists in the database'}
end
