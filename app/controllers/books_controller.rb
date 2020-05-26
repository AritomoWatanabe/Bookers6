class BooksController < ApplicationController


	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
	before_action :set_book

	def set_book
		@book = current_user.books.find_by(id: params[:id])
  	end


	def index
		@books = Book.page(params[:page])
		@book = Book.new
		@user = current_user
	end


	def create
		@book = Book.new(book_params)
		@books = Book.page(params[:page])
		@user = current_user
		@book.user_id = current_user.id
		if @book.save
			flash[:create] = "You have creatad book successfully."
			redirect_to book_path(@book.id)
		else
			@books = Book.all
			render "index"
		end
	end

	def show
		@book = Book.find(params[:id])
		@user = current_user
		@book_new = Book.new
	end


	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:update] = "You have updated book successfully."
			redirect_to book_path(@book.id)
		else
			@books = Book.all
			render "edit"
		end
	end

	private

	#Urlの直打ちを防止する
	def correct_user
		@book = current_user.books.find_by(id: params[:id])
    	unless @book
    		redirect_to books_path
    	end
  	end


	def book_params
		params.require(:book).permit(:title, :body)
	end

  	def user_params
  		params.require(:user).permit(:name, :introduction, :profile_image)
  	end

end
