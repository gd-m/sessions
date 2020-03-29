class ApplicationController < ActionController::API
    include ::ActionController::Cookies
   

    
    def login!
        session[:user_id] = @user.id        
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def logout!
        session.clear
    end
end
