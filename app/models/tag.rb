class Tag < ApplicationRecord
  has_many :gossip_tags
  validates_associated :gossip_tags
  has_many :gossips, through: :gossip_tags
  validates_associated :gossips
  validates :title, length: { in: 3..14 }
end
