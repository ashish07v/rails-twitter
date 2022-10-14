class TweetTestJob < ApplicationJob
  queue_as :default

  # before_enqueue do |job|
  #   p "before_enqueue job"
  # end

  # around_perform do |job, block|
  #   p "around_perform"
  # end

  def perform(id,uid)
    topic = Topic.find_by(id: id)
        
        if topic
          tf = topic.topic_followers.new
          tf.user_id = uid
          tf.save
        end
  end


end
