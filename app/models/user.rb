class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy


  def get_profile_image(width, height)

  unless profile_image.attached?

    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')

  end

  profile_image.variant(resize_to_limit: [width, height]).processed
  end

  enum role: { user: 0, admin: 10, customer: 20, }

  def self.guest

    find_or_create_by!(email: 'guest@example.com', name: 'ゲスト') do |user|
      user.password = SecureRandom.urlsafe_base64
    end

  end

  def is_guest?
    email != 'guest@example.com'
  end
end
