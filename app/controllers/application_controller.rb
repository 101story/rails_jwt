class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  
    def authenticate
        begin
        #token = params[:token]
        payload = JsonWebToken.decode(auth_token)
        puts payload
        @currnet_user = User.find(payload.first["sub"])
        puts @currnet_user.email
        rescue JWT::DecodeError
            render json: {errors:["Invalid Token Error"]}, status: :unauthorized
        end
    end
        
    def auth_token
        #값이 들어 있으면 그냥 있는걸로 하고 없으면 채워라 
        @auth_token ||= request.headers.fetch("Authorization", "")
    end
end
