class UsersController < ApplicationController

	def show
	  @user = User.find(params[:id])
	  @posts = Post.all
	end

	def new
	  @user = User.new
	end

	def create
	  @user = User.new(user_params)
	  if @user.save
	  	log_in @user
	  	flash[:notice] = 'User created successfully'
	  	redirect_to :root
	  else
	  	flash[:notice] = @user.errors.full_messages
	  	render('new')
	  end
	end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end	
end
