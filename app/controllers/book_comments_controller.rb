class BookCommentsController < ApplicationController
  
  def create
    @bookx = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = @bookx.id
    if @book_comment.save
      flash[:notice] = "Book Comment was successfully created."
      redirect_to request.referer
    else
      render template: "books/show"
    end
    
    
  end
  
  def destroy
    BookComment.find(params[:id]).destroy
    flash[:notice] = "Book Comment was successfully destroyed."
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
