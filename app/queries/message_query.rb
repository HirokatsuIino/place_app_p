class MessageQuery
  def initialize(relation = Message.all)
    @relation = relation.extending(Scopes)
  end

  def search
    @relation
  end

  def inboxes(user, other_user)
    search
      .where(
        '(from_user_id = :user AND to_user_id = :other_user) OR (from_user_id = :other_user AND to_user_id = :user)',
        user: user ? user.id : 0,
        other_user: other_user ? other_user.id : 0
      )
  end

  module Scopes
    def unread
      where(read_at: nil)
    end

    def to(user)
      where(to_user: user)
    end

    def from(user)
      where(from_user: user)
    end
  end
end
