class Api::V1::UsersController < ApplicationController
    
    def create
        @user = User.new(users_param)
        if @user.save!
            login!
            json_string = UserSerializer.new(@user)
            render json: {
                logged_in: true,
                user: @user
            }            
        else
            render json: {
                logged_in: false,
                error: @user.errors.full_messages.to_sentence,
                status: :unprocessable_entity
            }
        end
    end

    private

    def users_param 
        params.require(:user).permit(:email, :password)
    end
end
