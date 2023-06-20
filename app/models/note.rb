class Note < ApplicationRecord
  has_one_attached :picture
  belongs_to :user
  belongs_to :collection
  has_many :shared_notes

end
