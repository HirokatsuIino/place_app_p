class User < ActiveRecord::Base
  include Role

  after_create :notify_new_registration
  after_create :make_student_type, if: Proc.new { self.student? }
  after_create :skip_confirmation! if Rails.env.development? || Rails.env.test?

  devise :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :trackable,
    :validatable,
    :confirmable,
    :omniauthable,
    omniauth_providers: [:twitter, :facebook]

  has_many :feedbacks
  has_many :posts, foreign_key: :poster_id
  has_many :likes
  has_many :reposts
  has_many :replies
  has_many :notifications
  has_many :email_deliveries
  has_many :sent_messages,  class_name: 'Message', foreign_key: :from_user_id
  has_many :lessons
  has_many :feedbacks
  has_many :breach_reports, foreign_key: :reporter_id
  has_many :receive_emails, class_name: 'SentEmail', foreign_key: :recipient_id
  has_many :monthly_fees
  has_many :experience_notes

  has_many :support, class_name: 'SupportSupporter', foreign_key: :supporter_id
  has_many :support_users, through: :support
  has_many :supporter, class_name: 'SupportSupporter', foreign_key: :support_user_id
  has_many :supporters, through: :supporter

  has_one  :payforward, foreign_key: :introduced_id


  attachment :image

  enum role:       { member: 0, temp: 1, test: 4, admin: 10, pm: 11, customer_success: 12, other: 100 }
  enum status:     { active: 'active', inactive: 'inactive', step1: 'step1', step2: 'step2', step3: 'step3' }
  enum permission: { refused: 0, granted: 1 }

  with_options on: :create do
    validates :email,     presence: true
    validates :nickname,  presence: true
    validates :nickname,  uniqueness: true
  end

  validates :nickname,  presence: true,         if: lambda { |r| r.teacher? ? (r.step1? || r.active?) : !r.step3? }
  validates :nickname,  uniqueness: true,       if: lambda { |r| r.teacher? ? (r.step1? || r.active?) : !r.step3? }
  validates :senpre_id, presence: true,         if: lambda { |r| r.teacher? ? (r.step1? || r.active?) : (r.step3? || r.active?) }
  validates :senpre_id, uniqueness: true,       if: lambda { |r| r.teacher? ? (r.step1? || r.active?) : (r.step3? || r.active?) }
  validates :senpre_id, length: { minimum: 5 }, if: lambda { |r| r.teacher? ? (r.step1? || r.active?) : (r.step3? || r.active?) }
  validates :senpre_id, format: { :with => /\A[a-zA-Z0-9_]+\z/i, :message => "は英数小文字で入力してください"},
            if: lambda { |r| r.teacher? ? (r.step1? || r.active?) : (r.step3? || r.active?) }
  validates :image,     presence: true,         if: lambda { |r| r.teacher? ? false : (r.step3? || r.active?) }

  def service_available?
    staff?
  end

  def self.ceo
    User.find(3)
  end

  def point_calculator
    @point ||= PointCalculator.new(self)
  end

  def self.find_by_omniauth(auth, type)
    type.constantize.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email    = auth.info.email.presence || ''
      user.password = Devise.friendly_token[0, 20]
      user.nickname = auth.provider == 'twitter' ? auth.info.nickname : auth.extra.raw_info.nickname
      user.type     = type
    end
  end

  def password_required?
    super && provider.blank?
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def pf_introduced?
    Payforward.where(introduced_id: self.id).present?
  end

  def pf_introducer?
    Payforward.where(introducer_id: self.id).present?
  end

  def pf_introduced_by
    if pf_introduced?
      payforward = Payforward.find_by(introduced_id: self.id)
      User.find(payforward.introducer_id)
    end
  end

  def update_attribute!(name:, value:)
    case name
    when 'plan'          then self.plan          = value == 'normal' ? nil : 'special'
    when 'role'          then self.role          = value.to_i
    when 'status'        then self.status        = value
    when 'permission'    then self.permission    = value.to_i
    when 'email_allowed' then self.email_allowed = value
    when 'gender'        then self.gender        = value
    when 'grade'         then self.setting.grade = value
    when 'prefecture'    then self.setting.prefecture = value
    end
    self.updated_at = Time.zone.now
    save
    student_type.update_automatically!
  end

  def payforward_id=(value)
    if (number = Payforward.number(value)).present?
      Payforward.find_or_create_by(introduced_id: id) do |payforward|
        payforward.introducer_id = number
      end
    end
    write_attribute(:payforward_id, value)
  end

  private

  def skip_confirmation!
    confirm
  end

  def make_student_type
    self.create_student_type(position: 'Free')
  end

  def notify_new_registration
    NewUserRegistrationMailer.email(self).deliver_now
  end
end
