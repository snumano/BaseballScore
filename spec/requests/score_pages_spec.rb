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

  describe "score show" do
    let(:score) { FactoryGirl.create(:score, start_date: '2014-08-01', user: user) }

    context "as correct user" do
      before do
        sign_in user
        visit score_path(score)
      end

      describe "page" do
        it { should have_content("Score Detail") }
        it { should have_content(score.id) }
        it { should have_link("edit")}
        it { should have_link("delete")}
      end
    end
  end

  describe "score edit" do
    let(:score) { FactoryGirl.create(:score, start_date: '2014-08-01', user: user) }

    context "as correct user" do
      before do
        sign_in user
        visit edit_score_path(score)
      end

      describe "page" do
        it { should have_title("Edit Score") }
        it { should have_content("Edit Score: #{score.id}") }
      end

      describe "with valid information" do
        before do
          fill_in "score[t1]", with: 0
          fill_in "score[b1]", with: 1
          fill_in "score[t2]", with: 2
          fill_in "score[b2]", with: 3
          click_button "Update Score"
        end
        it { should have_content("Score Detail: #{score.id}") }
        it { should have_title("Score Detail") }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        specify { expect(score.reload.t1).to  eq 0 }
        specify { expect(score.reload.b1).to  eq 1 }
        specify { expect(score.reload.t2).to  eq 2 }
        specify { expect(score.reload.b2).to  eq 3 }

      end

      describe "with invalid information" do
        before do
          fill_in "score[team_top]", with: ""
          click_button "Update Score"
        end
        it { should have_selector('div#error_explanation') }
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