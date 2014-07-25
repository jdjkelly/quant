require 'spec_helper'

describe Users::Meals do
  include Users::Meals

  let(:user)   { Fabricate(:user)}

  before do
    3.times do |i|
      user.sleeps.create(start: Date.current - i.days, end: Date.current - i.days + 6.hours)
    end
  end

  describe "#sleeps_from" do
    context "search for 1 day ago" do
      it "finds 2 sleeps" do
        user.sleeps_from(Date.yesterday).length.should eq(2)
      end
    end

    context "search for today" do
      it "finds 1 meal" do
        user.sleeps_from(Date.current).length.should eq(1)
      end
    end
  end

  describe "#sleeps_after" do
    context "search for 1 day ago" do
      it "finds 1 sleep" do
        user.sleeps_after(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 0 sleeps" do
        user.sleeps_after(Date.current).length.should eq(0)
      end
    end
  end

  describe "#sleeps_before" do
    context "search for 1 day ago" do
      it "finds 1 sleep" do
        user.sleeps_before(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 2 sleeps" do
        user.sleeps_before(Date.current).length.should eq(2)
      end
    end
  end

  describe "#sleeps_on" do
    context "search for 1 day ago" do
      it "finds 1 sleep" do
        user.sleeps_on(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 1 sleep" do
        user.sleeps_on(Date.current).length.should eq(1)
      end
    end
  end
end
