require 'rails_helper'

RSpec.describe Comment, :type => :model do

  context "on a user" do
    subject { Comment.make!(:of_user) }
    it "the author should be a user" do
      expect(subject.author.class).to be(User)
    end
  end
end
