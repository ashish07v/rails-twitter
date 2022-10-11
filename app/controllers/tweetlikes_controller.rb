class TweetlikesController < ApplicationController
  before_action :require_login
  before_action :set_tweet, only: %i[ user_like user_dislike]
  before_action :set_tweetlike, only: %i[ show edit update destroy ]

  # GET /tweetlikes or /tweetlikes.json
  def index
    @tweetlikes = Tweetlike.all
  end

  # GET /tweetlikes/1 or /tweetlikes/1.json
  def show
  end

  # GET /tweetlikes/new
  def new
    @tweetlike = Tweetlike.new
  end

  # GET /tweetlikes/1/edit
  def edit
  end


  def user_like(ulike = 1, msg = "You like the tweet.") 
    # format.js { render @tweet}
    prelikes        = @tweet.tweetlikes.find_by(user_id: @user.id)

    if prelikes.nil?
      @likes          = @tweet.tweetlikes.new
      @likes.likes    = ulike
      @likes.user_id  = @user.id
      respond_to do |format|
        if @likes.save
          format.html { redirect_to twitter_url, notice:  msg}
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { redirect_to twitter_url, notice: "Request not completed." }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else      
      respond_to do |format|
        if prelikes.update(likes: ulike)
          format.html { redirect_to twitter_url, notice: msg }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { redirect_to twitter_url, notice: "Request not completed." }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def user_dislike
    user_like(2, "You dislike the tweet.")
  end

  # POST /tweetlikes or /tweetlikes.json
  def create
    @tweetlike = Tweetlike.new(tweetlike_params)

    respond_to do |format|
      if @tweetlike.save
        format.html { redirect_to tweetlike_url(@tweetlike), notice: "Tweetlike was successfully created." }
        format.json { render :show, status: :created, location: @tweetlike }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweetlike.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweetlikes/1 or /tweetlikes/1.json
  def update
    respond_to do |format|
      if @tweetlike.update(tweetlike_params)
        format.html { redirect_to tweetlike_url(@tweetlike), notice: "Tweetlike was successfully updated." }
        format.json { render :show, status: :ok, location: @tweetlike }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweetlike.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweetlikes/1 or /tweetlikes/1.json
  def destroy
    @tweetlike.destroy

    respond_to do |format|
      format.html { redirect_to tweetlikes_url, notice: "Tweetlike was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweetlike
      @tweetlike = Tweetlike.find(params[:id])
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweetlike_params
      params.fetch(:tweetlike, {})
    end
end
