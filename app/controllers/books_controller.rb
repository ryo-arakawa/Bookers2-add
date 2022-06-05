class BooksController < ApplicationController
  # 投稿一覧
  def index
    @user = current_user
    @book = Book.new
    @books = Book.page(params[:page])
  end

  # 新規投稿
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice:"You have created book successfully."
    else
      @user = current_user
      @books = Book.page(params[:page])
      render :index
    end
  end

  # 投稿詳細
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  # 投稿編集
  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  # 投稿更新
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice:"You have updated book successfully."
    else
      render :edit
    end
  end

  # 投稿削除
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
