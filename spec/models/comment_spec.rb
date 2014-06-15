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
      VCR.use_cassette "akismet/comment_spam" do
        comment = FactoryGirl.build(:comment, name: "Porn Master", site_url: "http://pornmasters.com", body: "Porn plus Viagra is awesome!",
                                    user_ip: request.remote_ip, user_agent: request.env['HTTP_USER_AGENT'],
                                    referrer: request.env['HTTP_REFERER'])
        expect(comment.spam?).to be true
        comment.save
        expect(comment.approved).to be false
      end
    end

    it "should identify ham" do
      VCR.use_cassette "akismet/comment_ham" do
        comment = FactoryGirl.build(:comment, user_ip: request.remote_id, user_ip: request.remote_ip,
                                    user_agent: request.env['HTTP_USER_AGENT'], referrer: request.env['HTTP_REFERER'])
        expect(comment.spam?).to be false
        comment.save
        expect(comment.approved).to be true
      end
    end
  end

  describe "notify_other_commenters" do
    let(:post) { create(:post) }

    before(:each) do
      allow_any_instance_of(Comment).to receive(:spam?).and_return(false)
      @c1   = create(:comment, commentable_id: post.id, commentable_type: "Post", name: "Peter", email: "parker@marvel.com")
      @c2   = create(:comment, commentable_id: post.id, commentable_type: "Post", :parent => @c1, name: "Steve" , email: "rogers@marvel.com" )
      @c1a  = create(:comment, commentable_id: post.id, commentable_type: "Post", name: "Tony", email: "stark@marvel.com")
    end

    it "should notify the commenter of a reply" do
      @c2.notify_other_commenters
      expect(email_count).to eq(2)
      expect(last_email.to).to include(@c1.email)
    end

    context "without parent" do
      it "should only notify the admin" do
        @c1a.notify_other_commenters
        expect(email_count).to eq(1)
        expect(last_email.to).to include("jrmy.ward@gmail.com")
      end
    end
  end

  describe "Validation" do |variable|
    [:body, :email, :name].each do |attr|
      it "#{attr} must have a value" do
        comment = FactoryGirl.build(:comment, attr => nil)
        expect(comment).to_not be_valid
        expect(comment.errors[attr]).to_not be nil
      end
    end

    it "requires a valid email format" do
      bad_emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      bad_emails.each do |bad_email|
        comment_with_invalid_email = FactoryGirl.build(:comment, email: bad_email)
        expect(comment_with_invalid_email).to_not be_valid
        expect(comment_with_invalid_email.errors[:email]).to_not be nil
      end
    end
  end
end
