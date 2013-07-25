class Admins::UsersController < AdminsController
  prepend_before_filter :authenticate_user!, :except => [:show]
  before_action :set_user, only: [:show, :edit, :update]

  # GET /members/users
  # def index
  #   @users = User.all
  # end

  def dashboard

  end

  # GET /members/users/1
  # def show
  # end

  # GET /members/users/new
  # def new
  #   @user = User.new
  # end

  # GET /members/users/1/edit
  def edit
  end

  # POST /members/users
  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     redirect_to @user, notice: 'User was successfully created.'
  #   else
  #     render action: 'new'
  #   end
  # end

  # PATCH/PUT /members/users/1
  def update
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true if @user.id == current_user.id
      redirect_to edit_user_path(@user), :notice => "User was successfully updated."
    else
      render "edit"
    end
  end

  # DELETE /members/users/1
  # def destroy
  #   @user.destroy
  #   redirect_to members_users_url, notice: 'User was successfully destroyed.'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email,
        :password, :password_confirm, :current_password
      )
    end
end
