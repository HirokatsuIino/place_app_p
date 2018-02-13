class Teachers::MypagesController < ApplicationController
  include Timelinable

  before_action :set_teacher
  before_action :accessible?

  def show
    render_timeline
  end

  private

  def posts
    posts = show_like_target_posts? ? like_target_posts : all_posts
    posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show_like_target_posts?
    params[:mode] == 'like'
  end

  def like_target_posts
    if teacher_signed_in?
      Post.where(id: @teacher.likes.order(created_at: :desc).limit(100).map { |like| like.target.post if like.target.present? }.compact)
    else
      likes      = @teacher.likes.order(created_at: :desc).limit(100)
      like_posts = likes.map { |like| like.target.post if like.target.present? }.compact
      like_posts.delete_if do |post|
        post.post_content.class == TeacherLog ||
        (post.post_content.class == Reply && (post.post_content.original_post.post_content.class == TeacherLog || post.post_content.target_post.post_content.class == TeacherLog)) ||
        (post.post_content.class == Repost && post.post_content.target_post.post_content.class == TeacherLog)
      end
      Post.where(id: like_posts)
    end
  end

  def all_posts
    if teacher_signed_in?
      PostQuery.new.search.with_poster(@teacher)
    else
      Post.where(poster_id: @teacher).where.not(post_content_type: 'TeacherLog', id: [Reply.for_teacher_log, Reply.for_reply_to_teacher_log, Repost.for_teacher_log].flatten.map(&:post))
    end
  end

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

  def accessible?
    authenticate!(:read, :others_mypage) unless access_own_mypage?
  end

  def access_own_mypage?
    teacher_signed_in? && current_user == @teacher
  end
end
