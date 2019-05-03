module SessionHelper

    def headers(from:, access_token: nil, client: nil, uid: nil)
        { 
            'access-token' => access_token || from.header['access-token'],
            'client' => client || from.header['client'],
            'uid' => uid || from.header['uid']
        }
    end

    def login_params(from:, email: nil, password: nil)
        { 
            email: email || from.email, 
            password: password || from.password
        }
    end

end