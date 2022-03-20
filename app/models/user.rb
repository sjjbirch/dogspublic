class User < ApplicationRecord

  has_many :dogs, dependent: :destroy
  has_many :adverts, through: :dogs
  has_many :seller_payments, class_name: 'Payment', foreign_key: 'seller_id'
  has_many :buyer_payments, class_name: 'Payment', foreign_key: 'buyer_id'
  accepts_nested_attributes_for :adverts, allow_destroy: true
  accepts_nested_attributes_for :dogs
  accepts_nested_attributes_for :buyer_payments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

         def sanitize_all
          # if you're reading this and marking, devise already sanitises
         end

end
