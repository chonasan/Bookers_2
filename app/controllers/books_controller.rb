class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comments = @book.book_comments
    @newbook = Book.new
    @book_comment = BookComment.new
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def edit
     @book = Book.find(params[:id])
    if @book.user == current_user
      render action: :edit
    else
      redirect_to books_path
    end
  end


  # 　@tweet = Tweet.new(tweet_params)  # フォームから送られてきたデータ(body)をストロングパラメータを経由して@tweetに代入
  #   @tweet.user_id = current_user.id # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
  #   @tweet.save
  #   redirect_to tweets_path

  def create
      @user = current_user
      @books = Book.all
      @book = Book.new(book_params) #Book.newの:title, :bodyを更新する
      @book.user_id = current_user.id #nillのidを更新
     if  @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
     else
      render action: :index
     end
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
   def book_params
    params.require(:book).permit(:title, :body, :profile_image)
   end

end
