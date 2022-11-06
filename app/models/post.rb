class Post < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
