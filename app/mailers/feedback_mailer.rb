#encoding: utf-8
class FeedbackMailer < ActionMailer::Base
  default from: "noreply@feedback.com"

  def notification(message)
    @message = message
    @site = @message.site
    @user = @site.user
    mail(:to => @user.email, :subject => "[feedback] новое сообщение с '#{@site.domain}'")
  end
end
