class AdministratorsController < ApplicationController
  layout 'administrators'
  before_action :authenticate_admin!
  before_action :set_breach_count

  def index
  end

  def skip_confirmation
    user = User.find(params[:skip_user_id])
    user.confirm
    flash[:notice] = user.email + 'の認証をスキップしました'

    redirect_to administrators_path
  end

  def teacher_select
    @teachers = User.where(type: "Teacher").order(updated_at: :desc)
    @student = Student.find(params[:student_id])
  end

  def confirmation
    if !current_user.admin?
      #センプレの全員がadminになっているので、セキュリティー上admin認証機能をoffにしています
      #current_user.role = 10
      current_user.save
      redirect_to root_path, notice: t('.confirmed')
    else
      redirect_to root_path, notice: t('.already')
    end
  end

  def select
    if params[:teacher_id].present?
      @teacher = User.find(params[:teacher_id])
    else
      redirect_to admin_teachers_path, notice: t('.select_teacher')
    end
  end

  def messages
    @messages = Message.all.order(created_at: :desc).page(params[:page]).per(100)

    render_ajax and return if request.xhr?
  end

  def permit_publish
    @teacher = Teacher.find(params[:teacher_id])
    @setting = TeacherSetting.find_by(teacher_id: params[:teacher_id])
    @setting.publish = 2
    @teacher.permission = 2
    @setting.save
    @teacher.save
    redirect_to admin_teacher_index_path, notice: "許可しました。"
  end

  def edit_parent_email
    @students = Student.all.order(created_at: :desc)
  end

  def skype
    @students = Student.all.where.not(role: 4).order(created_at: :desc)
  end

  def update_skype
    student = Student.find(params[:id])
    student.skype_id = params[:student][:skype_id]
    if student.save
      notice = 'skype_idを更新しました'
      if    params[:controller] == 'administrators'
        redirect_to administrators_path,   notice: notice
      elsif params[:controller] == 'customer_success'
        redirect_to cs_student_index_path, notice: notice
      end
    end
  end

  def data_collection_students
    @students = Student.where(role: 0).order(created_at: :desc)
    @eight_days_ago = Date.today - 8
    @yesterday = Date.today - 1
    @prefecture = ['','北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県', '茨城県', '栃木県', '群馬県',
                   '埼玉県', '千葉県', '東京都', '神奈川県', '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県',
                   '岐阜県', '静岡県', '愛知県', '三重県', '滋賀県', '京都府', '大阪府', '兵庫県', '奈良県', '和歌山県',
                   '鳥取県', '島根県', '岡山県', '広島県', '山口県', '徳島県', '香川県', '愛媛県', '高知県', '福岡県',
                   '佐賀県', '長崎県', '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県']
    @grade_hash = { '小1' => 'J1', '小2' => 'J2', '小3' => 'J3', '小4' => 'J4', '小5' => 'J5', '小6' => 'J6',
                    '中1' => 'JH1', '中2' => 'JH2', '中3' => 'JH3', '高1' => 'H1', '高2' => 'H2', '高3' => 'H3',
                    '浪人生' => 'AH', '保護者' => 'P', 'その他' => 'O' }
    @grade = @grade_hash.invert
  end

  def data_collection_teachers
    @teachers = Teacher.where.not(role: 4).includes(:posts, :replies, :reposts, :lessons, :likes).order(created_at: :desc)
  end

  def repost_data
    @teacher_ids = User.where(type: 'Teacher').pluck(:id)
    @student_ids = User.where(type: 'Student').pluck(:id)
    @reposts_of_teachers = Post.with_deleted.where(poster_id: @teacher_ids, post_content_type: "Repost", deleted_at: nil)
  end

  def reply_data
    @teacher_ids = User.where(type: 'Teacher').pluck(:id)
    @student_ids = User.where(type: 'Student').pluck(:id)
    @replys_of_teachers = Post.with_deleted.where(poster_id: @teacher_ids, post_content_type: "Reply"  , deleted_at: nil)
  end

  def teacher_fact_index
    if params[:month]
      @duration = params[:month].to_i.months.ago..Time.zone.now
    elsif params[:begin] && params[:end]
      @duration = Time.zone.parse(params[:begin])..Time.zone.parse(params[:end])
    else
      @duration = 1.month.ago..Time.zone.now
    end

    @duration = (@duration.begin + 1.day).to_date..@duration.end.to_date

    @teachers = TeacherQuery.new.search.not_test.sort_by do |teacher|
      teacher.fact.action_rate(@duration)
    end.reverse
  end

  def teacher_fact
    @teacher = Teacher.find(params[:id])
    if params[:month]
      @duration = params[:month].to_i.months.ago..Time.zone.now
    elsif params[:begin] && params[:end]
      @duration = Time.zone.parse(params[:begin])..Time.zone.parse(params[:end])
    else
      @duration = 1.month.ago..Time.zone.now
    end

    @duration = (@duration.begin + 1.day).to_date..@duration.end.to_date
  end

  def student_fact_index
    @students = StudentQuery.new.senpre_students.order(id: :asc)
    @duration = 1.month.ago..Time.zone.now
    @duration = (@duration.begin + 1.day).to_date..@duration.end.to_date
  end

  def select_date
  end

  def weekrepo_status
    lesson = Lesson.find(params[:id])
    children_lessons = Lesson.where(parent_id: lesson.id)

    need = lesson.weekrepo_need?
    lesson.weekrepo_need = !need


    children_lessons.each do |lesson|
      lesson.update!(weekrepo_need: !need)
    end
    lesson.save!

    redirect_to :repeat_reserved, notice: '週レポの状態を切り替えました。'
  end

  def teacher_fact_custom
    if params[:beginning] && params[:end].present?
      @beginning = Date.parse(params[:beginning])
      @end       = Date.parse(params[:end])
      @teachers = Teacher.all#.sort {|a,b| ApplicationController.helpers.action_percentage_average(b) <=> ApplicationController.helpers.action_percentage_average(a)}
    elsif Date.parse(params[:beginning]) > Date.parse(params[:end])
      redirect_to :teacher_fact_index, notice: "値が正しく入力されていません"
    else
      redirect_to :teacher_fact_index, notice: "値が正しく入力されていません"
    end
  end

  def select_for_like_count
    read_students_and_teachers_arr

    @select_user_ids =
        [['全ユーザー', @all_user_ids],
         ['全生徒', @all_student_ids],
         ['センプレチームを除く全センセイ', @teacher_ids_without_staff],
         ['センプレチームを含む全センセイ', @all_teacher_ids],
         ['センプレチームのみ', Role::STAFF_USER_IDS],
        ]

    User.all.order(created_at: :asc).map{|u| ["#{u.nickname} (#{u.id})",u.id]}.each do |user|
      @select_user_ids << user
    end
  end

  def like_count
    is_period  = params[:beginning].present? && params[:end].present?
    is_user_id = params[:first_user_id].present? || params[:second_user_id].present? || params[:third_user_id].present?

    notice = "値が正しく入力されていません"
    if is_period.present? && is_user_id.present?
      date_reverse_order = Date.parse(params[:beginning]) > Date.parse(params[:end])
      return redirect_to :select_for_like_count, notice: notice if date_reverse_order

      period = Date.parse(params[:beginning])..Date.parse(params[:end])

      @first_like  = search_nickname_and_like_count_by(period, params[:first_user_id])
      @second_like = search_nickname_and_like_count_by(period, params[:second_user_id])
      @third_like  = search_nickname_and_like_count_by(period, params[:third_user_id])
    else
      redirect_to :select_for_like_count, notice: notice
    end
  end

  private

  def set_breach_count
    @breach_reports_count        = BreachReport.all.count
    @unread_breach_reports_count = BreachReport.where(read_at: nil).count
  end

  def search_nickname_and_like_count_by(period, user_id)
    return ["なし", "-"] unless period.present? and user_id.present?
    read_students_and_teachers_arr

    case user_id
      when @all_user_ids.to_s
        nickname = '全ユーザー'
        user_id = @all_user_ids
      when @all_student_ids.to_s
        nickname = '全生徒'
        user_id = @all_student_ids
      when @teacher_ids_without_staff.to_s
        nickname = 'センプレチームを除く全センセイ'
        user_id = @teacher_ids_without_staff
      when @all_teacher_ids.to_s
        nickname = 'センプレチームを含む全センセイ'
        user_id = @all_teacher_ids
      when Role::STAFF_USER_IDS.to_s
        nickname = 'センプレチームのみ'
        user_id = Role::STAFF_USER_IDS
      else
        user = User.find(user_id)
        nickname = "#{user.nickname}(#{user.id})"
        user_id = user.id
    end

    like_count = Like.where(created_at: period,
                            user_id: user_id).count

    [nickname, like_count]
  end

  def read_students_and_teachers_arr
    @all_user_ids = User.all.pluck(:id)
    @all_student_ids = Student.all.pluck(:id)
    @all_teacher_ids = Teacher.all.pluck(:id)
    @teacher_ids_without_staff = Teacher.all.pluck(:id)
  end
end
