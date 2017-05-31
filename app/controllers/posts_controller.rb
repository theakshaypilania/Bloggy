class PostsController < ApplicationController
	http_basic_authenticate_with name: "akshay",password: "1234", except: [:index, :show]

	before_action :find_post,only:[:show, :edit, :update, :destroy]
	
	def index
		@posts = Post.all
	end

	def show
		
	end

	def new
		@post=Post.new
	end

	def create
		 @post = Post.new(post_params)
		 if @post.save
		 	redirect_to @post 
		 else
		 	render 'new'
		 end
	end

	def edit
		
	end

	def update
		if @post.update(post_params)
		 	redirect_to @post 
		 else
		 	render 'edit'
		 end
	end

	def destroy
		@post.destroy
		redirect_to posts_path 
	end

	private 
	def post_params
		params.require(:post).permit(:title, :body)

	end

	def find_post
		@post = Post.find(params[:id])
	end

end
