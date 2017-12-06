require 'jwt'
class JsonWebToken
    def self.encode(payload)
        JWT.encode payload, nil, 'none'
    end
    
    def self.decode(token)
        JWT.decode token, nil, false
    end
end