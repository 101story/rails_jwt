class User < ActiveRecord::Base
    #password 를 암호화 함
    has_secure_password
end
