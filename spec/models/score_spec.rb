require 'spec_helper'

describe Score do

  let(:user) { FactoryGirl.create(:user) }
  before { @score = user.scores.build(start_date: "2014-08-01", start_time: "09:00", team_top: "TEAM_A", team_bottom: "TEAM_B", t1: 0, b1: 1, t2:3, b2:1, t3:3, b3:1, t4:3, b4:1, t5:3, b5:1, t6:3, b6:1, user_id: user.id)}

  p @score
  subject { @score }

  it { should respond_to(:start_date) }
  it { should respond_to(:start_time) }
  it { should respond_to(:team_top) }
  it { should respond_to(:team_bottom) }
  it { should respond_to(:t1) }
  it { should respond_to(:b1) }
  it { should respond_to(:t2) }
  it { should respond_to(:b2) }
  it { should respond_to(:t3) }
  it { should respond_to(:b3) }
  it { should respond_to(:t4) }
  it { should respond_to(:b4) }
  it { should respond_to(:t5) }
  it { should respond_to(:b5) }
  it { should respond_to(:t6) }
  it { should respond_to(:b6) }
  it { should respond_to(:t7) }
  it { should respond_to(:b7) }
  it { should respond_to(:t8) }
  it { should respond_to(:b8) }
  it { should respond_to(:t9) }
  it { should respond_to(:b9) }
  it { should respond_to(:end) }
  it { should respond_to(:user_id) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @score.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank start_date" do
    before do
      @score.start_date = ""
    end
    it { should_not be_valid }
  end

  describe "with blank team name" do
    before do
      @score.team_top = " "
      @score.team_bottom = " "
    end
    it { should_not be_valid }
  end

  describe "with teamname that is too long" do
    before { @score.team_top = "a" * 11 }
    it { should_not be_valid }
  end

end

