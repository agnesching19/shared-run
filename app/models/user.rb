class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :runs
  has_many :events
  has_many :reviews
  validates :first_name, :last_name, :email, presence: true

  mount_uploader :photo, PhotoUploader
end
