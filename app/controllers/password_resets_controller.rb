class PasswordResetsController < ApplicationController
    def new
	@user=User.new
    end

    def edit
	@user = User.find_by(perishable_token: params[:id])
	redirect_to root_path unless @user
    end

    def create
	@user = User.find_by_email(params[:user][:email])
	if @user
	    @user.deliver_password_reset_instructions!
	    flash[:success] = "Instructions to reset your password have been emailed to you."
	    redirect_to root_path
	else
	    flash[:warning] = "No user was found with that email address"
	    @user=User.new
	    render :new
	end
    end

    def update
	@user = User.find_by(perishable_token: params[:id])
	if @user.update_attributes(password_reset_params)
	    flash[:success] = "Password successfully updated!"
	    redirect_to root_path
	else
	    render :edit
	end
    end

    private

    def password_reset_params
	params.require(:user).permit(:password, :password_confirmation)
    end
end
