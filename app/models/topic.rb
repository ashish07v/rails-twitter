class Topic < ApplicationRecord
	belongs_to :user
	has_many :topic_followers, dependent: :destroy
	# has_many :tweets, through: :topic_followers

	validates :topic_name, presence: true
end
