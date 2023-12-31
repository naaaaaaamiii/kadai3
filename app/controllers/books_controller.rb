class BooksController < ApplicationController
  
before_action :authenticate_user!
before_action :is_matching_login_user, only: [:edit] 
 
  def create
     @book_new = Book.new(book_params)
     @book_new.user_id = current_user.id
      if @book_new.save
         flash[:notice]="successfully!!!!!!!!!!!!!!!!!!!!!!!!!!create後"
         redirect_to book_path(@book_new.id)
      else
         @books = Book.all
         @user = current_user 
         render :index
      end
  end

  def index
     @user = current_user
     @book_new = Book.new
     @books = Book.all
  end

  def show
     @book = Book.find(params[:id])
     @user = @book.user
     @book_new = Book.new

  end

  def edit
     @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
       if @book.update (book_params)
          flash[:notice]="successfully!!!!!!!!!!!!!!!!!!!!!!!!!!"
          redirect_to book_path(@book.id)
       else
          render :edit
       end
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
           redirect_to books_path
    end
  end

end
