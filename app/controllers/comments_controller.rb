class CommentsController < ApplicationController
	http_basic_authenticate_with name: "pilania", password: "8860", only: [:destroy]
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments
		if @comment.create(comment_params)
			redirect_to post_path(@post)
		else 
			render @post
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private def comment_params
		params.require(:comment).permit(:username, :body)
	end

end
