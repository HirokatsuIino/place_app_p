class Students::MypagesController < ApplicationController
  include Timelinable

  before_action :set_student
  before_action :accessible?

  def show
    @coaching_teachers = TeacherQuery.new.search.coaching(@student)
    @duration = 1.month.ago..Time.zone.now
    @duration = (@duration.begin + 1.day).to_date..@duration.end.to_date
    render_timeline
  end

  private

  def posts
    posts = show_like_target_posts? ? like_target_posts : all_posts
    posts = posts.where.not(post_content_type: 'TeacherLog', id: [Reply.for_teacher_log, Reply.for_reply_to_teacher_log, Repost.for_teacher_log].flatten.map(&:post))
    posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show_like_target_posts?
    params[:mode] == 'like'
  end

  def like_target_posts
    Post.where(id: @student.likes.map { |like| like.target.post if like.target.present? }.compact)
  end

  def all_posts
    PostQuery.new.search.with_poster(@student)
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def accessible?
    authenticate!(:read, :others_mypage) unless access_own_mypage?
  end

  helper_method :access_own_mypage?
  def access_own_mypage?
    student_signed_in? && current_user == @student
  end
end
