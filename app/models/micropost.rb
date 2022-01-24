class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  ATTR_CHANGE = %i(content image).freeze
  delegate :name, to: :user, prefix: true

  validates :user_id, presence: true
  validates :content, presence: true,
                      length: {maximum: Settings.max_content}
  validates :image, content_type: {in: Settings.image_type,
                                   message: :invalid_format},
                    size: {less_than: Settings.max_image_size.megabytes,
                           message: :large_size}

  scope :recent_posts, ->{order(created_at: :desc)}
  scope :find_microposts_user,
        ->(user){where user_id: user.following_ids << user.id}

  def display_image
    image.variant resize_to_limit: [Settings.image_limit, Settings.image_limit]
  end
end
