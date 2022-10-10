class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tweetlikes, dependent: :destroy
  validates :body, presence: true
end
