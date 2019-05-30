class List < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user 
  validates :user, presence: true
end
