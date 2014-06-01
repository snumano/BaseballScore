require 'spec_helper'

describe "Score pages" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "new page" do
    context "with invalid signin" do
      before { visit root_path }

      it{should have_content('Sign up now!')}
    end

    context "with valid signin" do
      before do
        sign_in user
        visit root_path
      end
      it{should have_content('New Score')}

      describe "with invalid information" do
        before {click_link "New Score"}

        it "should not create a score" do
          expect { click_button "Create Score" }.not_to change(Score, :count)
        end

        describe "error messages" do
          before { click_button "Create Score" }
          it { should have_content('error') }
        end
      end
    end
  end

  describe "score creation" do
    before do
      sign_in user
      visit root_path
      click_link "New Score"
    end


    describe "with valid information" do

      before do
        fill_in 'score[team_top]',    with: "teamA"
        fill_in 'score[team_bottom]', with: "teamB"
      end

      it "should create a score" do
        expect { click_button "Create Score" }.to change(Score, :count).by(1)
      end
    end
  end

  describe "score destruction" do
    before { FactoryGirl.create(:score, start_date: '2014-08-01', user: user) }

    describe "as correct user" do
      before do
        sign_in user
        visit root_path 
      end

      it "should delete a score" do
        expect { click_link "delete" }.to change(Score, :count).by(-1)
      end
    end
  end


end