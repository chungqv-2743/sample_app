module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults

      helpers do
        def represent_user_with_token user
          request_token = user.create_request_token(token:
                               Authentication.encode(user_id: user.id))
          present token: request_token.token
        end
      end

      resources :auth do
        desc "GET/api/v1/sign_in"
        params do
          requires :email
          requires :password
        end

        post "/sign_in" do
          user = User.find_by email: params[:email]
          if user&.authenticate params[:password]
            represent_user_with_token user
          else
            error!("Invalid email/password combination", 401)
          end
        end

        desc "GET/api/v1/sign_out"
        get "/sign_out" do
          authenticate_user!
          rt = RequestToken.find_by(token: request.headers["Jwt-Token"])
          rt&.destroy
          present message: "logged out"
        end
      end
    end
  end
end
