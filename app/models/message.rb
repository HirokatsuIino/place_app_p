class Message < ActiveRecord::Base
  include Notifiable::MessageNotifiable
  include Emailable::MessageEmailable

  belongs_to :to_user,   class_name: 'User'
  belongs_to :from_user, class_name: 'User'

  has_many :images, class_name: 'MessageImage', dependent: :destroy
  accepts_attachments_for :images, attachment: :image, append: true

  validates :to_user_id,   presence: true
  validates :from_user_id, presence: true
  validates :content,      presence: true

  def other_user(user)
    (from_user == user) ? to_user : from_user
  end

  def read?
    !!read_at
  end

  def read!
    update_attribute(:read_at, Time.zone.now)
  end

  class << self
    def send_from_admin(to_user, content, image_id)
      self.skip_callback(:commit, :after, :email_deliver)
      message = self.new()
      message.content = content
      message.to_user = to_user
      message.from_user_id = 0
      message.save
      message.images << MessageImage.new(image_id: image_id) if image_id.present?
      self.set_callback(:commit, :after, :email_deliver)
    end

    def read_all!
      all.find_each do |message|
        message.read!
      end
    end
  end
end
