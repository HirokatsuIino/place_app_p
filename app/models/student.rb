class Student < User
  scope :next, Students::NextQuery
  scope :normal, Students::NormalQuery
  scope :trial, Students::TrialQuery
  scope :free, Students::FreeQuery

  has_many :lessons
  has_many :teachers, through: :lessons

  has_many :questions
  has_many :requests
  has_many :monthly_reports
  has_many :interview_logs
  has_many :after_interview_logs
  has_many :logs,         class_name: 'StudentLog'
  has_many :reports,      class_name: 'StudentReport'
  has_many :teacher_logs, class_name: 'TeacherLog'
  has_many :reviews,      class_name: 'TeacherReview'
  has_many :tutor_logs
  has_many :yomikos
  has_many :trial_test_logs
  has_many :exam_school_logs
  has_many :kakomon_logs
  has_many :student_facts
  has_many :parent_logs
  has_many :parent_greeting_logs
  has_many :kpi_facts

  has_one :setting, class_name: 'StudentSetting', inverse_of: :student
  has_one :profile, class_name: 'StudentProfile', inverse_of: :student
  has_one :payforward, foreign_key: :introduced_id
  has_one :student_type
  has_one :text_use

  accepts_nested_attributes_for :setting

  def service_available?
    super || lessons.normal || granted?
  end

  def new_students
    [
      729,
      730,
    ]
  end

  def number_jp_of_parent_interview(date)
    number = number_of_parent_interview(date)
    number == 0 ? '1回目' : "#{number+1}回目"
  end

  def number_of_parent_interview(date)
    logs = parent_logs.where('created_at < ?', date)
    if logs.present?
      parent_greeting_logs ? logs.count + 1 : 0
    else
      parent_greeting_logs.present? ? 1 : 0
    end
  end

  def new_lesson_logs
    # logs = [tutor_logs.where(draft: false), teacher_logs].flatten
    logs = [tutor_logs.where(draft: false)].flatten
    return nil if logs.empty?
    logs = logs.map { |log| [log, log.updated_at] }
    logs = logs.sort_by { |log| log[1] }.reverse
    logs.slice(0, 2).map(&:first)
  end

  def new_student?
    new_students.include?(self.id)
  end

  def trial_ticket
    @trial_ticket ||= TrialTicket.new(self)
  end

  def special_plan?
    self.plan == 'special'
  end

  def fact
    @fact ||= StudentFact.new(self)
  end

  def prev_teachers
    @prev_teachers ||= lessons.repeat.map(&:teacher)
  end

  def repeat_lesson_teachers
    @repeat_lesson_teachers ||= TeacherQuery.new.repeat_coaches(self).uniq.compact
  end

  def current_teacher
    lessons.normal.recently.map(&:teacher).uniq
  end

  def repeat_lesson_teacher
    lessons.normal.recently.map(&:teacher).uniq.first
  end

  def coached_teachers_recently
    TeacherQuery.new.search.coaching(self).coaching_recently.uniq.compact
  end

  def read_trial_logs_number
    trial_test_logs.read.count
  end

  def read_exam_school_logs_number
    exam_school_logs.read.count
  end

  def read_kakomon_logs_number
    kakomon_logs.read.count
  end

  def read_logs_number
    read_trial_logs_number +
    read_exam_school_logs_number +
    read_kakomon_logs_number
  end

  def unread_trial_logs_number
    trial_test_logs.unread.count
  end

  def unread_exam_school_logs_number
    exam_school_logs.unread.count
  end

  def unread_kakomon_logs_number
    kakomon_logs.unread.count
  end

  def unread_logs_number
    unread_trial_logs_number +
    unread_exam_school_logs_number +
    unread_kakomon_logs_number
  end

  def oldest_lesson_date
    lessons.normal.minimum(:lesson_datetime)
  end

  def reserve_trial_lesson?
    trial_ticket.used_number != 0
  end
end
