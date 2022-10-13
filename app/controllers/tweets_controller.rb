class TweetsController < ApplicationController
  before_action :require_login
  before_action :set_tweet, only: %i[ show edit update destroy ]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    
    @tweet = @user.tweets.new(tweet_params)
    @error = 'Invalid tweet'
    respond_to do |format|
      if @tweet.save
        format.js { render @tweet}        
      else
        format.js { render @tweet}        
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        # format.html { redirect_to tweet_url(@tweet), notice: "Tweet was successfully updated." }
        # format.json { render :show, status: :ok, location: @tweet }
        # format.js { render update}
        format.js { render 'update.js.erb' }
      else
        format.js { render 'update.js.erb' }
        # format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def show_modal    
    @edit_tweet = @user.tweets.find_by(id: params[:id])    
  end  


  def unfollow_topic
      respond_to do |format|
        if @user.topic_followers.find_by(topic_id: params[:id]).destroy        
          format.html { redirect_to topic_user_url(@user), notice: "unfollowed successfully." }              
        else
          format.html { redirect_to topic_user_url(@user), notice: "Invalid action." }
        end
     end
  end

  def follow_topic
    respond_to do |format|
      if !@user.topic_followers.find_by(topic_id: params[:id]).present?
        @topic = Topic.find_by(id: params[:id])
        
          if @topic
            tf = @topic.topic_followers.new
            tf.user_id = @user.id

            if tf.save
              format.html { redirect_to topic_user_url(@user), notice: "You followed on topic." }
              # format.json { render :show, status: :ok, location: @tweet }
              # format.js { render update}            
            else
              format.html { redirect_to topic_user_url(@user), notice: "Error, please try again." }
              # format.json { render json: @tweet.errors, status: :unprocessable_entity }
            end
          else
            format.html { redirect_to topic_user_url(@user), notice: "Not able to follow the topic." }
          end

        else
          format.html { redirect_to topic_user_url(@user), notice: "allready followed." }
        end
     end
  end

  def topic_tweet
    t = @user.topics.find_by(id: params[:id])
    if t.present?
      id = t.topic_followers.all.pluck(:user_id)
      if id.present?
        @tweet = Tweet.all.where(user_id: id)
        tweet_ids     = @tweet.pluck(:id)
        # @tweet_likes = Tweetlike.all.where(user_id: @user.id, tweet_id: tweet_ids).pluck(:tweet_id)
        @tweetlikes   = Tweetlike.all.where(tweet_id: tweet_ids)
        @tweetlikecount = @tweetlikes.group(:tweet_id, :likes).count
        @userlikestweet = @tweetlikes.where(user_id: @user.id).group(:tweet_id, :likes).count

      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = @user.tweets.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:body, :user_id)
    end
end
