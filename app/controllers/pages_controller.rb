class PagesController < ApplicationController
  def home
    return redirect_to timeline_path if user_signed_in? && current_user.active?
  end

  def top
  end

  def parents
    @inquiry = Inquiry.new
  end

  def staffs
    @profiles = profiles
  end

  def staff
    @profile = profiles[params[:id]]
  end

  def trial
  end

  def story
  end

#テスト追加 -S
  def experience_story
  end

  def story2
  end
#テスト追加 -E

  def explain_logs
    examples = [21083, 16913, 22456, 19111]
    @posts = Post.find(examples).index_by(&:id).slice(*examples).values
  end

  def explain_reports
    examples = [494, 1932, 2015, 1595, 2143, 2192, 78]
    @reports = StudentReport.find(examples).index_by(&:id).slice(*examples).values
  end

  def sakura
    @user = User.find(9)
    @total = 128 + StudentLogQuery.new.search.with_student(@user).count
    posts = [1574, 3960, 6541, 7282, 8309, 8706, 9148, 9644, 10821, 12024, 12111, 12457, 14556, 15517, 15761, 15908, 15958, 16145]
    posts.unshift(23119)
    @posts = Post.find(posts).index_by(&:id).slice(*posts).values
    @post_dates = [
      'センプレ入会 (高2・7月)',
      '半年後 (高3・1月)',
      '９ヶ月後 (高3・4月)',
      '１１ヶ月後 (高3・6月)',
      '１年後 (高3・7月上旬)',
      '１年後 (高3・7月下旬)',
      '１年１ヶ月後 (高3・8月上旬)',
      '１年１ヶ月後 (高3・8月中旬)',
      '１年１ヶ月後 (高3・8月下旬)',
      '１年２ヶ月後 (高3・9月)',
      '１年３ヶ月後 (高3・10月下旬)',
      '１年３ヶ月後 (高3・10月下旬)',
      '１年４ヶ月後 (高3・11月上旬)',
      '１年４ヶ月後 (高3・11月下旬)',
      '１年５ヶ月後 (高3・12月下旬)',
      '１年６ヶ月後 (高3・1月下旬)',
      '１年７ヶ月後 (高3・2月上旬)',
      '１年７ヶ月後 (高3・2月中旬)',
      '１年７ヶ月後 (高3・2月中旬)',
      '早稲田大学合格 (高3・2月下旬）',
    ]
    @post_grade = [
      '高2',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
    ]
    @story_url = 'http://company.senseiplace.com/taikenkisakura'
    render 'series'
  end

  def s
    @user = User.find(20)
    @total = 94 + StudentLogQuery.new.search.with_student(@user).count
    posts = [23798, 23799, 23800, 23801, 23802, 23803, 23804, 23805, 23806, 23807]
    @posts = Post.find(posts).index_by(&:id).slice(*posts).values
    @post_dates = [
      'センプレ入会 (高3・8月)',
      '5日後 (高3・8月)',
      '１ヶ月後 (高3・9月)',
      '２ヶ月後 (高3・10月)',
      '４ヶ月後 (高3・12月)',
      '５ヶ月後 (高3・1月)',
      '半年後 (高3・2月)',
      '半年後 (高3・2月)',
      '半年後(直前期) (高3・2月)',
      '早稲田大学合格 (高3・3月）',
    ]
    @post_grade = [
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
      '高3',
    ]
    @story_url = 'http://company.senseiplace.com/taikenkis'
    render 'series'
  end

  private

  def profiles
    {
      '3' => OpenStruct.new(
        image: 'shoji.jpg',
        name: '庄司センセイ',
        college: '早稲田大学',
        prefecture: '埼玉県',
        hobby: 'ラグビー観戦',
        comment: '一発逆転したい人待ってます'
      ),

      '708' => OpenStruct.new(
        image: 'takeda.jpg',
        name: 'うどんセンセイ',
        college: '早稲田大学',
        prefecture: 'うどん県',
        hobby: '散歩',
        comment: 'オススメのうどん屋おしえてください。'
      ),

      '709' => OpenStruct.new(
        image: 'dai.jpg',
        name: '湯川センセイ',
        college: '法政大学',
        prefecture: '和歌山県',
        hobby: '野球、バドミントン、英語、国際交流',
        comment: '頑張りたい人待ってます！'
      ),

      '710' => OpenStruct.new(
        image: 'satsuki.jpg',
        name: 'さつきセンセイ',
        college: '法政大学',
        prefecture: '高知県',
        hobby: '物をストックすること',
        comment: '自分を諦めたくない子！待ってます！'
      ),

      '722' => OpenStruct.new(
        image: 'shiome.jpg',
        name: 'くまがいセンセイ',
        college: '早稲田大学',
        prefecture: '宮城県',
        hobby: 'お城めぐり、読書',
        comment: 'たのしい受験生活を送ろう！'
      ),

      # '7' => OpenStruct.new(
      #   image: '',
      #   name: 'とも',
      #   college: '',
      #   prefecture: '',
      #   hobby: '',
      #   comment: ''
      # )
    }
  end
end
