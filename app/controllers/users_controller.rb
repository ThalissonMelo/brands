class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy,:show_follow_brands,
                                  :add_follow_brands, :unfollow_brand]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def add_follow_brands
    if Brand.find_by_id(params[:brand_id])
      if @user.user_follow_brands
        add_follow_brand_to_array
      else
        @user.user_follow_brands = [params[:brand_id]]
        save_user_follow_brands
      end
    else
      error = :"This brand does not exist"
      render json: error, status: :unprocessable_entity
    end
  end

  def add_follow_brand_to_array
    if @user.user_follow_brands.include?(params[:brand_id])
      error = :"You already follow this brand"
      render json: error, status: :unprocessable_entity
    else
      @user.user_follow_brands.push(params[:brand_id])
      save_user_follow_brands
    end
  end

  def show_follow_brands
    user_brand_response = { brands: {} }
    if user_brand_response[:brands] = @user.user_follow_brands
      render json: user_brand_response, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def unfollow_brand
    if @user.user_follow_brands.delete(params[:brand_id])
      save_user_follow_brands
    else
      error = :"You already delete this brand"
      render json: error, status: :unprocessable_entity
    end
  end

  def save_user_follow_brands
    if @user.save
      render json: @user.user_follow_brands, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :user_follow_brands)
    end
end
