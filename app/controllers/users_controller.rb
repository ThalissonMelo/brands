class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy,:show_follow_brands, :add_follow_brands,
                                  :friendship_invitations, :unfollow_brand, :show_invite_list,
                                  :friendship_invitations_array, :accept_invite_array,
                                  :accept_invite_array, :accept_friendship,
                                  :add_friendsip_on_user_that_invite, :show_user_friends]

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
        save_user
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
      save_user
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
      save_user
    else
      error = :"You already delete this brand"
      render json: error, status: :unprocessable_entity
    end
  end

  def save_user
    if @user.save
      render json: @user.user_follow_brands, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def friendship_invitations_array(guest_user)
    if guest_user.friendship_invitations.include?(@user.id)
      error = :"Invite already send"
      render json: error, status: :unprocessable_entity
    else
      if (guest_user.id).to_i != (@user.id).to_i
        guest_user.friendship_invitations.push(@user.id)
        guest_user.save
        message = :"Invite has been sent"
        render json: message, status: :ok
      end
    end
  end

  def friendship_invitations
    guest_user = User.find_by_id(params[:user_id])
    if guest_user
      if guest_user.friends_list
        if !(guest_user.friends_list.include?(@user.id))
          add_user_on_guest_friendship_invitation_list(guest_user)
        else
          error = :"You already friends"
          render json: error, status: :unprocessable_entity
        end
      else
        add_user_on_guest_friendship_invitation_list(guest_user)
      end
    else
      error = :"This user does not exist"
      render json: error, status: :unprocessable_entity
    end
  end

  def add_user_on_guest_friendship_invitation_list(guest_user)
    if guest_user.friendship_invitations
      friendship_invitations_array(guest_user)
    else
      if (guest_user.id).to_i != (@user.id).to_i
        guest_user.friendship_invitations = [@user.id]
        guest_user.save
        message = :"Invite has been sent"
        render json: message, status: :ok
      end
    end
  end

  def show_invite_list
    if @user.friendship_invitations
      user_invite_list = { invites: {} }
      if user_invite_list[:invites] = @user.friendship_invitations
        render json: user_invite_list, status: :ok
      else
        render status: :unprocessable_entity
      end
    else
      error = :"You have no invites"
      render json: error, status: :unprocessable_entity
    end
  end

  def accept_friendship
    if @user.friendship_invitations.include?(params[:user_id])
      accept_invite_array
      add_friendsip_on_user_that_invite
    else
      error = :"This invite does not exist"
      render json: error, status: :unprocessable_entity
    end
  end

  def add_friendsip_on_user_that_invite
    invited_user = User.find_by_id(params[:user_id])
    if invited_user.friends_list
      if !(invited_user.friends_list.include?(@user.id))
        invited_user.friends_list.push(@user.id)
      end
    else
      invited_user.friends_list = [@user.id]
    end
    invited_user.save
  end

  def accept_invite_array
    if @user.friends_list
      if @user.friends_list.include?(params[:user_id])
        error = :"This invite has already be accept"
        render json: error, status: :unprocessable_entity
      else
        @user.friends_list.push(params[:user_id])
        @user.friendship_invitations.delete(params[:user_id])
        @user.save
        message = :"The invitation was accepted"
        render json: message, status: :ok
      end
    else
      @user.friends_list = [params[:user_id]]
      @user.friendship_invitations.delete(params[:user_id])
      @user.save
      message = :"The invitation was accepted"
      render json: message, status: :ok
    end
  end

  def show_user_friends
    if @user.friends_list
      user_friends_list = { friends: {} }
      if user_friends_list[:friends] = @user.friends_list
        render json: user_friends_list, status: :ok
      else
        render status: :unprocessable_entity
      end
    else
      error = :"You do not invide friends yet, invide one!"
      render json: error, status: :unprocessable_entity
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
