class Api::V1::SessionsController < ApplicationController

    def create
        @user = User.find_by(email: params[:session][:email])
        if @user && @user.authenticate(params[:session][:password])
            login!
            json_string = UserSerializer.new(@user)
            render json: {
                logged_in: true,
                user: json_string
            }
        else
            render json: {
                logged_in: false,
                error: "Invalid Credentials"
            }
        end
    end

    def get_current_user
        if logged_in?
            json_string = UserSerializer.new(current_user)
            render json: {
                logged_in: true,
                user: json_string
            }
        else
            render json: 
            {
                error: "No One Logged In",
                logged_in: false
            }
        end
    end

    def destroy
        logout!
        render json: {
      notice: "successfully logged out"
    }, status: :ok
    end
end
