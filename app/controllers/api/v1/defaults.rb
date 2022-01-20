module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from :all do |e|
          raise e if Rails.env.development?

          error_response(message: e.message, status: 500)
        end

        helpers do
          def authenticate_user!
            token = request.headers["Jwt-Token"]
            if RequestToken.find_by token: token
              user_id = Authentication.decode(token)["user_id"]
              @current_user = User.find_by id: user_id
            end
            return if @current_user

            api_error!("You need to log in to", "failure", 401, {})
          end

          def api_error! message, error_code, status, header
            error!({message: message, code: error_code}, status, header)
          end
        end
      end
    end
  end
end
