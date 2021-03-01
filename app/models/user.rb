class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 20 }      # 「50文字以下」
  validates :name, length: { minimum: 2 }  
  validates :introduction, length: { maximum: 50 } 
end
