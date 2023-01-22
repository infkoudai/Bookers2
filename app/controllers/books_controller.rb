class BooksController < ApplicationController
  before_action :authenticate_user!
  
  
  def index
    @books = Book.all
    @book = Book.new
  end
  
  # 投稿データの保存
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def show
    @bookx = Book.find(params[:id])
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to '/books'
    end
  end
  
  def update
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to '/books'
    end
    if @book.update(book_params)
      flash[:notice] = "Book was successfully update."
      redirect_to book_path(@book.id)
    else
      render :edit
    end 
  end
  
  def destroy
    book = Book.find(params[:id]) 
    book.destroy  
    flash[:notice] = "Book was successfully destroyed."
    redirect_to '/books'    
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  
end
