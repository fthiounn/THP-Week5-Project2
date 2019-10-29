class User < ApplicationRecord
  belongs_to :city
  has_many :likes
  validates_associated :likes
  has_many :gossips
  validates_associated :gossips
  has_many :comments
  validates_associated :comments
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  validates_associated :sent_messages
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "RecipientList"
  validates_associated :received_messages

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "please enter a valid email" }
  validates :age, :numericality => { :greater_than_or_equal_to => 0 }
end


