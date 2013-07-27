require 'spec_helper'

describe Post do
  it { should respond_to(:abstract) }
  it { should respond_to(:author_id) }
  it { should respond_to(:body) }
  it { should respond_to(:description) }
  it { should respond_to(:published_at) }
  it { should respond_to(:slug) }
  it { should respond_to(:title) }

  describe "Lists" do
    it "finds published" do
      a = create(:post, :published_at => 2.weeks.ago)
      b = create(:post, :published_at => 2.weeks.from_now)
      Post.published.should include(a)
      Post.published.should_not include(b)
    end

    it "finds unpublished" do
      a = create(:post, :published_at => 2.weeks.ago)
      b = create(:post, :published_at => 2.weeks.from_now)
      Post.unpublished.should include(b)
      Post.unpublished.should_not include(a)
    end
  end

  it "keeps existing slug" do
    a = create(:post, :published_at => 2.weeks.ago)
    a.update_attribute(:title, "Hello World 2")
    a.slug.should eq("hello-world")
  end

  it "knows if it's the last published post" do
    a = create(:post, :published_at => 2.weeks.ago)
    b = create(:post, :published_at => 1.week.ago)
    c = create(:post, :published_at => 2.weeks.from_now)
    a.should_not be_last_published
    b.should be_last_published
    c.should_not be_last_published
  end

  # it "assigns tags to a post" do
  #   post = create(:post, :tag_list => 'foo, bar')
  #   post.tag_list.should eq(%w[foo bar])

  # end

  describe "Validations" do
    [:abstract, :body, :description, :published_at, :title].each do |attr|
      it "#{attr} must have a value" do
        post = build(:post, attr => nil)
        post.should_not be_valid
        post.errors[attr].should_not be_nil
      end
    end
  end

end
