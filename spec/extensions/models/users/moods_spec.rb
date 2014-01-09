require 'spec_helper'

describe Users::Moods do
  include Users::Moods

  let(:user)   { Fabricate(:user)}

  before do
    3.times do |i|
      user.moods.create(date: Date.current - i.days, rating: 1, description: "Some stuff happened")
    end
  end

  describe "#moods_from" do
    context "search for 1 day ago" do
      it "finds 2 moods" do
        user.moods_from(Date.yesterday).length.should eq(2)
      end
    end

    context "search for today" do
      it "finds 1 mood" do
        user.moods_from(Date.current).length.should eq(1)
      end
    end
  end

  describe "#moods_after" do
    context "search for 1 day ago" do
      it "finds 1 mood" do
        user.moods_after(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 0 moods" do
        user.moods_after(Date.current).length.should eq(0)
      end
    end
  end

  describe "#moods_before" do
    context "search for 1 day ago" do
      it "finds 1 mood" do
        user.moods_before(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 2 moods" do
        user.moods_before(Date.current).length.should eq(2)
      end
    end
  end

  describe "#moods_on" do
    context "search for 1 day ago" do
      it "finds 1 mood" do
        user.moods_on(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 1 mood" do
        user.moods_on(Date.current).length.should eq(1)
      end
    end
  end
end
