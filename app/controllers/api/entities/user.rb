module API
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :request_token, using: RequestToken
    end
  end
end
