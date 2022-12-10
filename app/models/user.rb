class User < ApplicationRecord
  GUEST_EMAIL = "guest@example.com"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :encrypted_password, presence: true


  enum role: { user: 0, admin: 10, customer: 20, }

  def self.guest
    find_or_create_by!(email: GUEST_EMAIL) do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # def get_profile_image(width, height)
  #   unless profile_image.attached?
  #     file_path = Rails.root.join("app/assets/images/no_image.jpg")
  #     profile_image.attach(io: File.open(file_path), filename: "no_image.jpg", content_type: "image/jpeg")
  #   end

  #   profile_image.variant(resize_to_limit: [width, height]).processed
  #   # profile_image.variant(resize_to_limit: [100, 100]).processed
  # end

  def is_guest?
    email == GUEST_EMAIL
  end
end
