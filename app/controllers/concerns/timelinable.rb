module Timelinable
  extend ActiveSupport::Concern

  included do
    helper_method :render_post_list
  end

  def render_timeline
    @posts = posts
    render_ajax and return if request.xhr?
  end

  def render_post_list
    render_to_string partial: 'timelines/post_list', locals: { posts: @posts }
  end

  private

  def posts
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  def render_ajax
    unless @posts.current_page > @posts.total_pages
      render json: {
        html: render_to_string(partial: 'posts/post', collection: @posts),
        next: render_to_string(partial: 'timelines/read_more'),
        last_page: @posts.current_page == @posts.total_pages
      }, status: :ok
    else
      render :nothing
    end
  end
end