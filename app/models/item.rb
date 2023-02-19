class Item < ApplicationRecord
  has_one_attached :image
  has_many :favorites
  belongs_to :customer
  has_many :genres

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width,height]).processed
  end
end