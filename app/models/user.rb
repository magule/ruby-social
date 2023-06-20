class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  has_many :shared_notes


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  followability
         # Add :username to the devise method
         validates :username, presence: true, uniqueness: true

         has_many :notes
         has_many :collections
         scope :private_to_user, ->(user) { where(user_id: user.id) }

         def delete_associated_records
             notes.destroy_all
             collections.destroy_all
        end
end
