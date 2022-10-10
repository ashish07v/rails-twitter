class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_tweet, only: %i[ new user_comment user_create_comment]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    # byebug
    # @edit_tweet = @users.tweets.find_by(id: params[:id])
    
  end

  # GET /comments/1/edit
  def edit
  end

  def user_comment    
    @comment = @tweet.comments.new
  end

  def user_create_comment   

    @comment = @tweet.comments.new
    @comment.comment = comment_params['comment']
    @comment.user_id = @user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to twitter_url, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to twitter_url, notice: "Request not completed." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /comments or /comments.json
  def create
    byebug
    comment_params
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.fetch(:comment, {})
    end
end
