require 'securerandom'

class UsersController < ApplicationController

    #register page
    def new
	if current_user_guest?
	    @user=current_user
	    @user.email=nil
	    @user.name=nil
	else
	    @user = User.new
	end
    end

    def edit
	@user = User.find(params[:id])
    end

    def create
	@user = User.new(users_params)
	if @user.save
	    flash[:success] = "Account registered!"
	    redirect_to root_path
	else
	    render :new
	end
    end

    def update
	@user = User.find(params[:id])
	if current_user_guest?
	    #register guest
	    if @user.update(users_params)
		flash[:success] = "Account registered!"
		redirect_to root_path
	    else render :new
	    end

	else
	    #regular update
	    @user.update(user_params)
	    render :edit
	end
    end

    #guest create
    def new_temp
	temp_password=SecureRandom.hex
	@user = User.new(name: "guest",
			 email: "guest-#{Time.now.to_i}@morningpages.ink",
	password: temp_password,
	    password_confirmation: temp_password)

	if @user.save
	    flash[:success] = "Welcome!"
	    return redirect_to user_pages_path(@user)
	end

	redirect_to root_path #something went wrong
    end

    private

    def users_params
	params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
