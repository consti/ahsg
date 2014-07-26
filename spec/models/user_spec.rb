require 'rails_helper'

RSpec.describe User, :type => :model do

  context "a valid user" do
    let(:valid_user){ User.make }
    describe "on save" do
      subject { -> { valid_user.save } }
      it { should change(Location, :count).by(1) }
      it { should change(User, :count).by(1) }
    end
    context "who graduated" do
      let(:graduated_user){ User.make(graduated: true) }
      describe "on save" do
        subject { -> { graduated_user.save } }
        it { should change(Location, :count).by(1) }
        it { should change(User, :count).by(1) }
        it { should change(GraduatingClass, :count).by(1) }
      end
      describe "on destroy" do
        before(:each) { graduated_user.save }
        subject { -> { graduated_user.destroy } }
        it { should change(Location, :count).from(1).to(0) }
        it { should change(User, :count).from(1).to(0) }
        it { should change(GraduatingClass, :count).from(1).to(0) }
      end
    end
  end

  context "two users with the same location" do
    let(:two_users) {
      first = User.make
      second = User.make(location: first.location)
      [first, second]
    }
    it "should not destroy the location if one users gets destroyed" do
      expect{ two_users.each(&:save) }.to change{ Location.count }.from(0).to(1)
      expect{ two_users.sample.destroy }.to_not change{ Location.count }
    end
    it "should destroy the location if all users gets destroyed" do
      expect{ two_users.each(&:save) }.to change{ Location.count }.from(0).to(1)
      expect{ two_users.each(&:destroy) }.to change{ Location.count }.from(1).to(0)
    end
  end

  context "two users in the same graduation class" do
    let(:graduated_users){
      [User.make(school_year_end: Date.today, graduated: true),
      User.make(school_year_end: Date.today, graduated: true)]
    }
    describe "when saved" do
      it "creates one GraduatingClass" do
        expect{ graduated_users.each(&:save) }.to(
          change(GraduatingClass, :count).from(0).to(1))
      end
    end
    describe "when one is destroyed" do
      before(:each) { graduated_users.map(&:save) }
      subject { -> { graduated_users.sample.destroy } }
      it { should change(User, :count).from(2).to(1) }
      it { should_not change(GraduatingClass, :count) }
    end
  end
end
