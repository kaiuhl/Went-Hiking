class PostsController < ApplicationController
	def index
		@posts = Post.all
	end
	def new
		@post = Post.new
	end
	def create
		@post = Post.new(params[:post])
		if @post.save
			redirect_to :back, :notice => "Added Post successfully."
		else
			render :new
		end
	end
	def show
		@post = Post.find(params[:id])
	end
	def edit
		@post = Post.find(params[:id])
	end
	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
			redirect_to :back, :notice => "Updated Post successfully."
		else
			render :edit
		end
	end
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to :back, :notice => "Deleted succesfully."
	end
end