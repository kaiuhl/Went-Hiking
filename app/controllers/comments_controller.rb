class CommentsController < ApplicationController
	before_filter :authorize
		
	def index
		@comments = Comment.where(:user_id => current_user.id)
	end
	
  def create
		@comment = Comment.new(params[:comment])
		@hike = @comment.hike
		@author = @comment.user
		if @comment.save
			WebsiteMailer.deliver_comment_posted(@comment) if @hike.user.notify_on_comment && (@hike.user.id != @author.id)
			
			@replies = @hike.comments.map{ |c| c.user }.uniq
			@replies.each do |previous_poster|
			begin
				if previous_poster.id != @author.id # don't email if the current poster is also a previous one
				if previous_poster.id != @hike.user.id # don't email if the current poster is the hike poster
				if previous_poster.notify_on_comment # make sure notifications are on
					WebsiteMailer.deliver_reply_posted(@comment, previous_poster)
				end
				end
				end
			rescue
			end
			end
			
			redirect_to user_hike_path(@comment.hike.user, @comment.hike) + "#comment_#{@comment.id}"
		end
  end
	
	def edit
		@comment = Comment.find(params[:id])
		@hike = @comment.hike
		redirect_to :back unless current_user.id == @comment.user_id
	end
	
	def update
		@comment = Comment.find(params[:id])
		@hike = @comment.hike
		redirect_to :back unless current_user.id == @comment.user_id
		if @comment.update_attributes(params[:comment])
			redirect_to "#{user_hike_path(@hike.user, @hike)}#comment_#{@comment.id}"
		else
			render :action => "edit"
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:notice] = "Deleted comment."
		redirect_to :back
	end
end
