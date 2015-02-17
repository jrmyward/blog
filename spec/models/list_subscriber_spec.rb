require 'rails_helper'

describe ListSubscriber, type: :model do
  it { should respond_to(:email) }
  it { should respond_to(:confirmed) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:postal_code) }

  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
  end
end
