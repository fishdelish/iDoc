class CommentsController < ApplicationController
  before_filter :find_menu_items, :except => [:destroy]
  before_filter :find_documentation_page, :except => [:recent]

  def new
    allowed_to? :create, Comment do
      @comment = build_comment(@documentation_page)
    end
  end

  def create
    allowed_to? :create, Comment do
      begin
        create_comment!(@documentation_page, params[:comment])
        created_successfully
      rescue
        create_failed
      end
    end
  end

  def destroy
    @comment = @documentation_page.comments.find(params[:id])
    allowed_to? :destroy, @comment do
      @comment.destroy
      flash[:notice] = "Comment deleted"
      redirect_to @documentation_page
    end
  end

  def recent
    allowed_to? :manage, Comment do
      @comments = Comment.recent
    end
  end

  private

  def find_documentation_page
    @documentation_page = DocumentationPage.find(params[:documentation_page_id])
  end

  def create_comment!(parent, comment_params = nil)
    @comment = build_comment(parent, comment_params)
    @comment.save!
  end

  def build_comment(parent, comment_params = nil)
    comment = parent.comments.build(comment_params)
    comment.user = current_user
    return comment
  end

  def created_successfully
    flash[:notice] = "Comment added"
    redirect_to @documentation_page
  end

  def create_failed
    flash.now[:error] = "Your comment could not be saved"
    render :action => :new
  end
end
