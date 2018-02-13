class Students::AfterInterviewLogsController < ApplicationController
  before_action :accessible?

  def index
    @interviews = AfterInterviewLog.all.order(created_at: :desc)
  end

  def show
    @interview = AfterInterviewLog.find(params[:id])
  end

  def new
    @student   = Student.find(params[:student_id])
    @interview = @student.after_interview_logs.new(content: template)
  end

  def create
    @student   = Student.find(params[:student_id])
    @interview = AfterInterviewLog.new(after_interview_params)

    if @interview.save
      student = @interview.student
      teacher = current_user
      message = "体験生 #{student.nickname}さんの体験指導後ログが #{teacher.nickname}さんによって作成されました"
      message += "\n"
      message += "[詳細をみる](#{student_after_interview_log_url(student, @interview)})"
      message = Slack::Notifier::Util::LinkFormatter.format(message)
      SlackNotifier.notify('#r2-consulting', message, ':memo:')

      redirect_to student_profile_path(@student), notice: '後面談ログを作成しました。'
    else
      render :new
    end
  end

  def edit
    @student   = Student.find(params[:student_id])
    @interview = AfterInterviewLog.find(params[:id])
  end

  def update
    @student    = Student.find(params[:student_id])
    @interview  = AfterInterviewLog.find(params[:id])

    if @interview.update(after_interview_params)
      redirect_to student_profile_path(@student), notice: '後面談ログを編集しました。'
    else
      render :edit
    end
  end

  private

  def accessible?
    student = Student.find(params[:student_id])
    forbidden unless (teacher_signed_in? && current_user.coaching?(student)) || staff_signed_in?
  end

  def template
    template = <<-"EOD"
担当：

日時：

・率直な感想（どうだった？）

・指導について(具体的に、学んだこと、新しい発見・気づき)

・時間ついて（長く感じた？短く感じた？ちょうど？&それは何故だと思う？）

・センセイについて（印象）

・学校や塾との違いは感じた？（こういうスタイルのこういう学びってこれまで体感したことある？）

・継続についての意志確認（こういう指導が毎週１回、年５２回の山登りをしたら、自分が成長していきそう、上がっていきどうなイメージって持てた？&実際継続したい？）

・所感

・その他（どんなセンセイが合っているか？スタンダードとプロどちらを希望しそうか？）

---------------------------
※事後面談の流れ
・お疲れ様!!!と声かけ（テンション高く）
・感想、体験指導での新しい学びや気づきのヒアリング（指導はどうだった？どんなところが学びになったか、どう活用していけそうか ※盛り上がる）
・センセイからの感想伝達（センセイと少し話して、○○さんのことを是非応援していきたいと言ってたよ！）
・継続意志の確認（○○さんとしてはセンプレの指導をうけてみて、続けていきたいと思った？）
・質問、不明点の確認と説明
・保護者の方への伝達前の不明点や懸念点の確認（親NGの事前対策）
・料金の簡単な説明（料金ネガの事前対策トーク）
・学びログ記載の伝達
・レビュー依頼
    EOD
    template
  end

  def after_interview_params
    params
      .require(:after_interview_log)
      .permit(
        :student_id,
        :content
      )
  end
end
