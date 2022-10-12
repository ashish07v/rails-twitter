class TweetTestJob < ApplicationJob
  queue_as :default

  # before_enqueue do |job|
  #   p "before_enqueue job"
  # end

  # around_perform do |job, block|
  #   p "around_perform"
  # end

  def perform(*args)
    p "new job"
  end


end
