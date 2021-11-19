class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :foods
  has_many :recipes
  has_many :inventories

  validates :name, presence: true
  before_validation :trim_whitespace

  def trim_whitespace
    self.name = name.strip unless name.nil?
  end
end
