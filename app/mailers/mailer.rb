class Mailer < ActionMailer::Base
  default from: "support@jrmyward.com"

  def comment_response(comment, parent)
    @comment = comment
    @user    = parent
    mail to: @user.email, subject: "Comment Response on jrmyward.com"
  end

  def notify_admin_and_author(comment)
    @comment = comment
    mail to: "jrmy.ward@gmail.com", subject: "New comment on #{@comment.commentable.title}"
  end
end
