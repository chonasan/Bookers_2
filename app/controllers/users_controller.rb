class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @book = Book.new
    @books = Book.where(user_id: params[:id])
    
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
      
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      
      
      if @isRoom
        
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    
  end


  def edit
    @user = User.find(params[:id])
    if @user == current_user
       
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end
  
   def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        NotificationMailer.complete_mail(@user).deliver_now  # (1)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
   end
  
  
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end



  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
