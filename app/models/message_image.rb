class MessageImage < ActiveRecord::Base
  belongs_to :message

  attachment :image
end
