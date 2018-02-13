class MonthlyReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reports = MonthlyReport.select("DISTINCT ON(datetime_number) *").order("datetime_number DESC, id ASC")
  end

  def new
    @report = MonthlyReport.new
  end

  def create
    StudentQuery.new.senpre_students.uniq.each do |student|
      report = MonthlyReport.new(monthly_report_params)
      report.student = student
      report.summary = summary(student)
      report.point   = point_info(student)
      report.save
    end

    redirect_to monthly_reports_path
  end

  def show
    @users  = Student.senpre_students
    @report = MonthlyReport.find(params[:id])
  end

  def report
    return unless valid_xhr_request?

    datetime_number = MonthlyReport.find(params[:report_id]).datetime_number
    report = MonthlyReport.find_by(student_id: params[:user_id], datetime_number: datetime_number)
    render partial: '/monthly_reports/student_monthly_report', locals: { report: report }
  end

  private

  def point_info(student)
    calc = PointCalculator.new(student)
    @prev_month      = 1.month.ago.month
    @monthly_receive = calc.monthly_receive_point(1.month.ago)
    @monthly_pay     = calc.monthly_pay_point(1.month.ago)
    @remaining_point = calc.current_point
    @prev_monthly_remaining_point = @remaining_point - calc.monthly_receive_point + calc.monthly_pay_point
    render_to_string action: :point_info, layout: false
  end

  def summary(student)
    # TODO: Issue 334では学習サマリー出力は実装しない
    ''
  end

  def valid_xhr_request?
    request.xhr? && params[:report_id].present? && params[:user_id].present?
  end

  def monthly_report_params
    params.require(:monthly_report).permit(:message, :datetime_number)
  end
end
