class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
     @book.save
     redirect_to books_path  #indexページに行く
  end

  def index
     @user = current_user
     @book = Book.new
     @books = Book.all
  end

  def show
     @user = current_user
     @book = Book.new
     @books = current_user.books
  end

  def edit
    @books = Book.all
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
