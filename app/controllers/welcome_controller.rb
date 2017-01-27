class WelcomeController < ApplicationController
    before_action :alert_if_guest

end
