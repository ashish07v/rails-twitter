class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_login,  only: %i[ index follow_user unfollow]
  before_action :check_sign_in,  only: %i[ sign_in ] 

  # GET /users or /users.json
  def index

    @following = @user.followers.pluck(:following_id)
    @followed  = User.all.where(id: @following) 
    @following << @user.id
    @users_all = User.all.where.not(id: @following) 
    
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end 

  # GET /users/new
  def sign_in
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def follow_user
    f = @user.followers.new
    f.following_id = params[:id]
    respond_to do |format|
      if f.save
        format.html { redirect_to users_url, notice: "You following one new user." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to users_url, notice: "Request not completed." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end  

  # POST /users or /users.json
  def create
    check = User.find_by(username: user_params[:username])
    respond_to do |format|
      if check.nil?
        @user = User.new(user_params)      
        if @user.save
          # format.html { redirect_to user_url(@user), notice: "User was successfully created." }
          format.html { redirect_to root_url, notice: "User was successfully created." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end      
      else
        format.html { redirect_to root_url, notice: "Username already exist." }
      end
    end
  end

  def unfollow
    @user.followers.find_by(following_id: params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "unfollowed successfully ." }
      format.json { head :no_content }
    end
  end


  # post/users/login
  def user_login
    @user = User.find_by(username: params[:user][:username])
    if @user.try(:authenticate, params[:user][:password])
    # if @user
    reset_session
    session[:user_id]   = @user.id
    session[:user_name] = @user.username
    redirect_to twitter_url
  else
        # format.html { redirect_to sign_in_url, notice: "Invalid credential." }
        redirect_to sign_in_url+"?error"
      end
    end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
  end
