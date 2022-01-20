module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      helpers do
        def find_user id
          @user = User.find id
        end
      end

      resource :users do
        desc "Return all users"
        get "", root: :users do
          authenticate_user!
          users = User.all
          present users, with: API::Entities::User
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end

        get ":id", root: "user" do
          authenticate_user!
          find_user params[:id]
          present @user, with: API::Entities::User
        end
      end

      resource :users do
        desc "Create a user"
        params do
          requires :name
          requires :email
          requires :password
          requires :password_confirmation
        end
        post "", root: "user" do
          @user = User.new params
          if @user.save
            present @user, with: API::Entities::User
          else
            error!("create fails", 401)
          end
        end
      end

      resource :users do
        desc "Update a user"
        put ":id", root: "user" do
          authenticate_user!
          find_user params[:id]
          if @user.update params
            present @user, with: API::Entities::User
          else
            error!("update fails", 401)
          end
        end

        desc "Delete a user"
        delete ":id", root: "user" do
          authenticate_user!
          find_user params[:id]
          if @user.destroy
            present @user, with: API::Entities::User
          else
            error!("Delete fails", 401)
          end
        end
      end
    end
  end
end
