class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    authors = Author.all
    # short_content
    render json: authors, include: ['posts', 'short_content', 'posts.tags', 'profile']
  end

  def show
    author = Author.find(params[:id])
    # short_content
    render json: author, include: ['posts', 'short_content', 'posts.tags', 'profile']
  end

  private

  def render_not_found_response
    render json: { error: "Author not found" }, status: :not_found
  end

  def short_content
    if params[:author_id]
      author = Author.find(params[:author_id])
      author.posts.map do |post|
        post.content.length > 40 ? "#{post.content[0..39]}..." : post.content
      end 
    else
      authors.each do |author|
        author.posts.map do |post|
          post.content.length > 40 ? "#{post.content[0..39]}..." : post.content
        end
      end
    end
  end

end
