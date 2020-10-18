class User < ApplicationRecord
  include WithUid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :registerable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:saml]

  before_validation :generate_uid, on: :create

  enum role: { visitor: 0, editor: 10, admin: 20 }

  has_many :articles, foreign_key: 'author_id', dependent: :nullify

  def self.from_omniauth(auth)
    user = self.where(email: auth.info.email.downcase)
            .first_or_initialize(password: "#{Devise.friendly_token[0,20]}!")

    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.role = auth.info.blog_role
    user.save
    user
  end

  def to_s
    full_name.blank? ? email : full_name
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
