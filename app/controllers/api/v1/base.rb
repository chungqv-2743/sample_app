require "grape-swagger"

module API
  module V1
    class Base < Grape::API
      mount V1::Users
      mount V1::Auth
      mount V1::Microposts
      mount V1::Followed
      mount V1::Follower

      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true
      )
    end
  end
end
