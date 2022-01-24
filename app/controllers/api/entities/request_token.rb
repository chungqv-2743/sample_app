module API
  module Entities
    class RequestToken < Grape::Entity
      expose :token
    end
  end
end
