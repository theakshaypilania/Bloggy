class CommentsController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :comment_owner, only: [:edit, :update, :destroy]
     
     def comment_owner
       @post=Post.find(params[:post_id])
       @comment=@post.comments.find(params[:id])
      unless @comment.user_id == current_user.id||@comment.post.user_id==current_user.id
       flash[:notice] = 'Access denied'
       redirect_to post_path(@post)
      end
     end

	def show
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def create
		@post= Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id	
		@comment.save
		if @comment.save
			flash[:success]='Comment created successfully'
			redirect_to post_path(@post) 
		else 
			flash[:notice]='Error posting comment'
			redirect_to post_path(@post) 
		end
	end

	def edit
		 @post= Post.find( params[:post_id] )
    	 @comment=@post.comments.find(params[:id])
	end

	def update
		  @post= Post.find( params[:post_id] )
		  @comment=@post.comments.find(params[:id])
    	if @comment.update(comment_params)
        	flash[:success]='Comment updated successfully'
      		redirect_to post_path(@post)
    	else
    		flash[:notice]='Error posting comment'
      		render 'edit'
    	end
  	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		flash[:success]='Comment deleted successfully'
		redirect_to post_path(@post)
	end

	private 

	def comment_params
		params.require(:comment).permit(:username, :body)
	end

end
