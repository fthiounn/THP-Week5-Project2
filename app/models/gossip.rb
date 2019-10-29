class Gossip < ApplicationRecord
  belongs_to :user
  has_many :gossip_tags
  validates_associated :gossip_tags
  has_many :tags, through: :gossip_tags
  validates_associated :tags
  has_many :comments
  validates_associated :comments
  has_many :likes
  validates_associated :likes
  validates :title, length: { in: 3..14 }
  validates :content, presence: true
end
