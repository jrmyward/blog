class Mailer < ActionMailer::Base
  default from: "support@jrmyward.com"

  def comment_response(comment_id, notify_id)
    @comment = Comment.find(comment_id)
    @user    = Comment.find(notify_id)
    mail to: @user.email, subject: "Comment Response on jrmyward.com"
  end

  def notify_admin_and_author(comment_id)
    @comment = Comment.find(comment_id)
    mail to: "jrmy.ward@gmail.com", subject: "New comment on #{@comment.commentable.title}"
  end
end
