require 'rails_helper'

describe UserDecorator, type: :decorator do
  let(:user) { create(:user, role: 'author') }
  let(:subject) { UserDecorator.decorate(user) }

  describe "#full_name" do
    it "returns a concatination of a user's first and last names" do
      expect(subject.full_name).to eq "#{user.first_name} #{user.last_name}"
    end
  end

end
