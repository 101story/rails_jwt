class AuthenticationController < ApplicationController
    def login
        u = User.find_by(email: params[:user][:email])
        if u and u.authenticate(params[:user][:password])
            #로그인 성공
            render json: {token: JsonWebToken.encode({sub: u.id})}
        else
            #로그인 실패
            render json: {errors: ["Invalid email or password"]}
            
        end
        
    end
    
    def authenticate
        #token = params[:token]
        begin
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
