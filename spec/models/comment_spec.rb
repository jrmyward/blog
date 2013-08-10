require 'spec_helper'
require "ostruct"

describe Comment do
  it { should respond_to(:body) }
  it { should respond_to(:email) }
  it { should respond_to(:site_url) }
  it { should respond_to(:user_ip) }
  it { should respond_to(:user_agent) }
  it { should respond_to(:referrer) }
  it { should respond_to(:approved) }

  describe "Akismet" do
    let(:request) { OpenStruct.new(remote_ip: '127.0.0.1', env: { 'HTTP_USER_AGENT' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/20100101 Firefox/17.0', 'HTTP_REFERER' => 'http://jrmyward.dev/blog/posts/hello-world' }) }

    it "should identify spam" do
      comment = FactoryGirl.build(:comment, name: "Porn Master", site_url: "http://pornmasters.com", body: "Porn plus Viagra is awesome!",
                                  user_ip: request.remote_ip, user_agent: request.env['HTTP_USER_AGENT'],
                                  referrer: request.env['HTTP_REFERER'])
      comment.spam?.should be_true
      comment.save
      comment.approved.should be_false
    end

    it "should identify ham" do
      comment = FactoryGirl.build(:comment, user_ip: request.remote_id, user_ip: request.remote_ip,
                                  user_agent: request.env['HTTP_USER_AGENT'], referrer: request.env['HTTP_REFERER'])
      comment.spam?.should be_false
      comment.save
      comment.approved.should be_true
    end
  end

  describe "Validation" do |variable|
    [:body, :email, :name].each do |attr|
      it "#{attr} must have a value" do
        comment = FactoryGirl.build(:comment, attr => nil)
        comment.should_not be_valid
        comment.errors[attr].should_not be_nil
      end
    end

    it "requires a valid email format" do
      bad_emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      bad_emails.each do |bad_email|
        comment_with_invalid_email = FactoryGirl.build(:comment, email: bad_email)
        comment_with_invalid_email.should_not be_valid
        comment_with_invalid_email.errors[:email].should_not be_nil
      end
    end
  end
end