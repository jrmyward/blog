class Admin::UsersController < AdminController
  prepend_before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  # GET /members/users
  # def index
  #   @users = User.all
  # end

  def dashboard
    page      = Sanitize.clean(params[:page])
    @comments = Comment.paginate(:page => page, :per_page => 10).order("created_at desc")
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
    if @user.update_with_password(params[:user])
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
      @user ||= User.find(params[:id])
    end

end