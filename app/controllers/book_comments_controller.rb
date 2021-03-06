class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
    comment = @book.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.user_id = current_user.id
    comment.save
  end

  def destroy
    BookComment.find(params[:id]).destroy
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
  end



  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
