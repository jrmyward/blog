class NewsletterService

  attr_accessor :newsletter, :newsletter_list

  def initialize(args={})
    @newsletter       = Gibbon::API.new(Rails.application.secrets.mail_chimp)
    @newsletter_list  = args[:list_id] || Rails.application.secrets.mail_chimp_list
  end

  def subscribe(user)
    newsletter.lists.subscribe( {id: newsletter_list, email: { email: user.email }, merge_vars: { :FNAME => user.first_name }, double_optin: true } )
  rescue Gibbon::MailChimpError => e
    Rails.logger.info "MailChimp error while subscribing guest to list: #{e.message}"
    false
  end
end