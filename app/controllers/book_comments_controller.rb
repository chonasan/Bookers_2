class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = book.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.user_id = current_user.id
    comment.save

  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy

  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
