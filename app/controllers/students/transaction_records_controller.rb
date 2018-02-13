class Students::TransactionRecordsController < ApplicationController
  before_action :authenticate_self!

  def index
    @student = Student.find(params[:student_id])

    @record_manually      = record_manually
    @record_automatically = record_automatically
  end

  private

  def record_manually
    TransactionRecordQuery.new.search
      .manually
      .with_user(@student)
      .order(created_at: :desc)
  end

  def record_automatically
    TransactionRecordQuery.new.search
      .automatically
      .with_user(@student)
      .order(processed_time: :desc)
  end
end
