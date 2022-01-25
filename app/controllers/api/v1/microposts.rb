module API
  module V1
    class Microposts < Grape::API
      include API::V1::Defaults

      helpers do
        def correct_user
          @micropost = @current_user.microposts.find_by id: params[:id]
          return if @micropost

          flash[:danger] = t "micropost_invalid"
          redirect_to request.referer || root_url
        end

        def build_micropost micropost_params
          @micropost = @current_user.microposts.build micropost_params
        end
      end

      resource :microposts do
        desc "Return all microposts"
        get "", root: :microposts do
          authenticate_user!
          microposts = Micropost.recent_posts
          present microposts, with: API::Entities::Micropost
        end
      end

      resource :microposts do
        desc "Create a micropost"
        params do
          requires :content
        end
        post "", root: "micropost" do
          authenticate_user!
          build_micropost params
          if @micropost.save
            present @micropost, with: API::Entities::Micropost
          else
            error!("create fails", 401)
          end
        end
      end

      resource :microposts do
        desc "Delete a micropost"
        delete ":id", root: "micropost" do
          authenticate_user!
          correct_user
          if @micropost.destroy
            present message: "deleted micropost"
          else
            error!("Delete fails", 401)
          end
        end
      end
    end
  end
end
