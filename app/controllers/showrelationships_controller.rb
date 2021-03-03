class ShowrelationshipsController < ApplicationController
   def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    @user = User.find(params[:id])
    redirect_to user_path(@user.id)
   end

    def destroy
      follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
      follow.destroy
      @user = User.find(params[:id])
      redirect_to user_path(@user.id)
    end
    
    private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
    
    
end
