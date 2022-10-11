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
    # @tweet = Tweet.new(tweet_params)
    @tweet = @user.tweets.new(tweet_params)
    @error = 'Invalid tweet'
    respond_to do |format|
      if @tweet.save
        format.js { render @tweet}
        # format.html { redirect_to twitter_url(@tweet), notice: "Tweet was successfully created." }
        # format.json { render :show, status: :created, location: @tweet }
      else
        # format.js { render 'users/show_updated_view'}
        format.js { render @tweet}
        # format.html { redirect_to twitter_url(@tweet), notice: "Error" }
        # format.json { render json: @tweet.errors, status: :unprocessable_entity }
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
