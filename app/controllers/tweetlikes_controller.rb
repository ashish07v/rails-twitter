class TweetlikesController < ApplicationController
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

    # Only allow a list of trusted parameters through.
    def tweetlike_params
      params.fetch(:tweetlike, {})
    end
end
