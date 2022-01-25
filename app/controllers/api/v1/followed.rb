module API
  module V1
    class Followed < Grape::API
      include API::V1::Defaults

      resource :followeds do
        desc "Return all users followed"
        get ":id", root: :followeds do
          authenticate_user!
          @user = User.find_by id: params[:id]
          if @user
            @users = @user.following
          else
            error!("Not found", 404)
          end
          present @users, with: API::Entities::User
        end
      end
    end
  end
end
