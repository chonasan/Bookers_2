class BooksController < ApplicationController
  
  def show
    @book = Book.new
    @book = Book.find(params[:id])
  end
  
  def index
     @book = Book.new
     @books = Book.all
  end
  
  def create
      @book = Book.new(book_params)
      @books = Book.all
     if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
     else
      redirect_to book_path(@book.id)
     end
  end
  
end
