module API
  module V1
    class Follower < Grape::API
      include API::V1::Defaults

      resource :followers do
        desc "Return all users follower"
        get ":id", root: :followers do
          authenticate_user!
          @user = User.find_by id: params[:id]
          if @user
            @users = @user.followers
            present @users, with: API::Entities::User
          else
            error!("Not found", 404)
          end
        end
      end
    end
  end
end
