class Gossip < ApplicationRecord
  belongs_to :user
  has_many :gossip_tags
  has_many :tags, through: :gossip_tags
  has_many :comments
  has_many :likes
  validates :title, length: { in: 3..14 }
  validates :content, presence: true
end
