class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :find_post,only:[:show, :edit, :update, :destroy]
	before_action :post_owner, only: [:edit, :update, :destroy]

	def post_owner
       @post=Post.find(params[:id])
       unless @post.user_id == current_user.id
       flash[:notice] = 'Access denied'
       redirect_to posts_path
      end
     end

	def index
		@posts = Post.search(params[:search]).order("created_at DESC").paginate(page: params[:page],per_page: 7)
	end

	def show
		@comments = Comment.where(post_id: @post)
	end

	def new
		@post= current_user.posts.build
	end

	def create
		 @post = current_user.posts.build(post_params)
		 if @post.save
		 	redirect_to posts_path,  :notice => "Post Posted"
		 else
		 	render 'new'
		 end
	end

	def edit
		
	end

	def update
		if @post.update(post_params)
		 	redirect_to posts_path, :notice => "Post Updated" 
		 else
		 	render 'edit'
		 end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, :notice => "Post Deleted"
	end

	private 
	def post_params
		params.require(:post).permit(:title, :body)

	end

	def find_post
		@post = Post.find(params[:id])
	end

end
