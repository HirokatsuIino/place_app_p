class ActionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @teachers = TeacherQuery.new.search.member.sort_by do |teacher|
      teacher.fact.action_rate(1.month.ago...Time.now).value
    end.reverse
  end
end
