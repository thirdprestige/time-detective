class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accountings,
    -> { where('confirmed_at IS NOT NULL') },
    dependent: :destroy
  has_many :accounts, through: :accountings
end
