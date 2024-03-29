class Item < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy #destroyで商品消えたら消える
  belongs_to :customer, optional: true
  belongs_to :genre, optional: true
  has_many :comments, dependent: :destroy

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(gravity: :center, resize:"#{width}x#{height}^")
  end

  def favorite?(customer)
   favorites.where(customer_id: customer.id).exists?
  end
  
  validates :name, presence: true, length: { minimum: 1}  # 最小
  validates :introduction, presence: true, length: { minimum: 1}  # 最小
end