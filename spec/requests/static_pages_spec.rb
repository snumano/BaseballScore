require 'spec_helper'

describe "Static pages" do
  subject{page}

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before{visit root_path}
    let(:heading)    { 'Baseball Score' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it{should_not have_title('| Home')}

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:score, user: user, start_date: "2014-08-01", team_top: "teamA1", team_bottom: "teamB1")
        FactoryGirl.create(:score, user: user, start_date: "2014-08-02", team_top: "teamA2", team_bottom: "teamB2")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        p user.scores
        user.scores.each do |score|
          expect(page).to have_selector("li .id", text: score.id)
        end
      end
    end
  end

  describe "Help page" do
    before{visit help_path}
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before{visit about_path}
    let(:heading)    { 'About Us' }
    let(:page_title) { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before{visit contact_path}
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "Baseball Score"
    expect(page).to have_title(full_title(''))
  end
end
