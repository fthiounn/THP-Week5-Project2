class Comment < ApplicationRecord
  belongs_to :gossip, optional: true
  belongs_to :commentable, polymorphic: true, optional: true
  belongs_to :user
  has_many :likes
  validates_associated :likes
  has_many :comments, as: :commentable
  validates_associated :comments
  validates :content, presence: true
end
