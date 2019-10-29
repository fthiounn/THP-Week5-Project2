class Tag < ApplicationRecord
  has_many :gossip_tags
  has_many :gossips, through: :gossip_tags
  validates :title, length: { in: 3..14 }
end
