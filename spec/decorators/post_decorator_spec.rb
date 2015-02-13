require 'rails_helper'

describe PostDecorator, type: :decorator do
  let(:author) { create(:user, role: "author") }
  let(:post) { create(:post, published_at: 2.weeks.ago, author_id: author.id, is_commentable: true) }
  let(:subject) { post.decorate }

  describe "#link_to_author" do
    describe "when they have a google plus page" do
      it "should link to an author's google plus page" do
        author.update_attribute(:gplus, '12345')
        expect(subject.link_to_author).to eq "<a target=\"_blank\" href=\"https://plus.google.com/12345?rel=author\">Peter Parker</a>"
      end
    end

    describe "when they don't have a google plus page" do
      it "should NOT link to an author's google plus page" do
        author.update_attribute(:gplus, nil)
        expect(subject.link_to_author).to eq "#{subject.author_full_name}"
      end
    end
  end

  describe "#published_date" do
    it "returns an empty string for unpublished posts" do
      unpublished_post = create(:post, published_at: nil).decorate
      expect(unpublished_post.published_date).to eq ""
    end

    it "returns a formated date string" do
      expect(subject.published_date).to eq post.published_at.strftime("%d %b %Y")
    end
  end

  describe '#published_date_en' do
    it "returns a formated date string" do
      expect(subject.published_date_en).to eq post.published_at.strftime("%B %d, %Y")
    end
  end

  describe "#published_status" do
    context "not published" do
      it "returns draft" do
        p = create(:post, published_at: nil).decorate
        expect(p.published_status).to eq "draft"
      end
    end

    context "currently published" do
      it "returns published" do
        p = create(:post, published_at: 1.day.ago).decorate
        expect(p.published_status).to eq "published"
      end
    end

    context "scheduled to be published" do
      it "returns scheduled" do
        p = create(:post, published_at: 2.days.from_now).decorate
        expect(p.published_status).to eq "scheduled"
      end
    end
  end

  describe '#status_badge' do
    it 'returns a formatted span tag' do
      expect(subject.status_badge).to eq "<span class=\"label label-success\">published</span>"
    end
  end

  describe '#status_label_css' do
    context 'when published' do
      it 'returns success' do
        allow(subject).to receive(:published_status).and_return 'published'
        expect(subject.status_label_css).to eq 'success'
      end
    end

    context 'when scheduled' do
      it 'returns info' do
        allow(subject).to receive(:published_status).and_return 'scheduled'
        expect(subject.status_label_css).to eq 'info'
      end
    end

    context 'when anything else' do
      it 'returns default' do
        allow(subject).to receive(:published_status).and_return 'something else'
        expect(subject.status_label_css).to eq 'default'
      end
    end
  end

end
