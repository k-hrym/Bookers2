class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
    @book = Book.new
  end

  def index
    @users = User.all.order(created_at: :desc)
    @book = Book.new
    @user = current_user
  end


  def edit
  	@user = current_user
  end

  def update
  end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
end