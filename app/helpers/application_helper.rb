require 'uri'

module ApplicationHelper
  def body_class
    "#{controller_name}_controller #{action_name}_action"
  end

  def set_alert(key, message)
    if message.empty?
      return
    end

    html = <<-EOD
      <div class="alert alert--#{key}">
        <span>メッセージ</span>
        <ul>
    EOD

    Array(message).each do |m|
      html << "<li>#{m}</li>"
    end

    html << <<-EOD
        </ul>
      </div>
    EOD

    content_for :alert, html.html_safe
  end

  def reputate(integer)
    case integer
    when 1
      '1(まったくできていない)'
    when 2
      '2(あまりできていない)'
    when 3
      '3(一歩届かなかった)'
    when 4
      '4(だいたいプラン通りで'
    when 5
      '5(プラン通りできた)'
    when 6
      '6(プラン以上にできた)'
    end
  end

  class ActionView::Helpers::FormBuilder
    def rate_buttons(name)
      html = '<div class="form-rate_buttons">'

      (1..5).each do |i|
        case i
        when 1
          message = "最悪！"
        when 2
          message = "残念"
        when 3
          message = "ふつう"
        when 4
          message = "それなり"
        when 5
          message = "よかった"
        end
        html << <<-EOD
          #{radio_button(name, i)} #{i} #{message}
        EOD
      end

      html << '</div>'
      html.html_safe
    end
    def reputation_buttons(name)
      html = '<div class="form-rate_buttons">'

      (1..6).each do |i|
        html << <<-EOD
          #{radio_button(name, i)} #{i}
        EOD
      end

      html << '</div>'
      html.html_safe
    end
  end

  def url_to_link(text)
    URI.extract(text, ['http', 'https']).uniq.each do |url|
      sub_text = ''
      sub_text << '<a href=' << url << '>' << url << '</a>'
      text.gsub!(url, sub_text)
    end
    text
  end

  def send_grid_link_of(user)
    link_to "#{user.email}", "https://app.sendgrid.com/email_activity?email=" + user.email, {:target => "_blank"}
  end

  def twitter_link_of(user)
    link_to "https://twitter.com/intent/user?user_id=#{user.uid.to_s}", target: "_blank" do
      image_tag "twitter_logo_blue.png", height: "24px"
    end
  end

  def parent_logs_eval_selection
    [['5 非常に良い', 5], ['4 良い', 4], ['3 まあまあ', 3], ['2 あまりよくない', 2], ['1 よくない', 1]]
  end

  def user(user_id)
    User.find(user_id)
  end
  
end
