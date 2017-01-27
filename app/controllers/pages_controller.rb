class PagesController < ApplicationController
    before_action :alert_if_guest, only: [:new, :edit]

    def index
	@pages=current_user.pages.order(:date)
	if today_page_exists?
	    redirect_to edit_user_page_path(current_user,@pages.last)
	else
	    redirect_to new_user_page_path
	end
    end

    def new
	redirect_to edit_user_page_path(current_user, current_user.pages.last) if today_page_exists?
	@page = Page.new
    end

    def edit
	@page = current_user.pages.find(params[:id])
	render 'new'
    end

    def create
	@user = User.find(current_user.id)
	if (@page = @user.pages.create(page_params)).id!=nil
	    render json: @page
	else
	    render plain: "creation failed", status: 500
	end
    end

    def update
	@page = Page.find(params[:id])
	if @page.update(page_params)
	    render json: @page
	else
	    render plain: "update failed", status: 500
	end
    end

    def today_page_exists?
	current_user.pages.exists?(date: Date.today)
    end

    private

    def page_params
	params.require(:page).permit(:body)
    end
end
