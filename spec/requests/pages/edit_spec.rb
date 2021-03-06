require 'spec_helper'

describe "user editing page" do
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in(user)
    visit edit_page_path(user)
  end
  subject { page }

  describe "should successfully edit the user attributes with valid information" do
    let(:new_name)  { "Joe Smoe" }
    let(:hn_username) { "jsmoe" }
    let(:linked_in)  { "http://wwww.linkedin.com" }
    let(:personal_site) { "http://www.google.com" }
    let(:twitter_username)  { "jsmoetwitter" }
    let(:github_username) { "jsmoe-github" }
    let(:about_me) { "a little about me." }
    let(:profile_pic) { "test.jpg" }
    before do
      fill_in "Full Name", with: new_name
      fill_in "Hacker News Username", with: hn_username
      fill_in "LinkedIn Public URL", with: linked_in
      fill_in "Personal Site (e.g. blog)", with: personal_site
      fill_in "Twitter Username", with: twitter_username
      fill_in "GitHub Username", with: github_username
      fill_in "A Little About Me", with: about_me
      # attach_file 'Upload a Profile Picture', "#{Rails.root}/spec/fixtures/images/code.png"
      click_button "Save changes"
    end
    it { should have_content("Edit Your Page") } 
    specify { user.page.reload.name.should  == new_name }
    specify { user.page.reload.hnusername.should  == hn_username }
    specify { user.page.reload.linkedin_username.should  == linked_in }
    specify { user.page.reload.personal_site.should  == personal_site }
    specify { user.page.reload.twitter_username.should  == twitter_username }
    specify { user.page.reload.github_username.should  == github_username }
    specify { user.page.reload.about_text.should  == about_me }
  end

  describe "should not save with invalid information" do
    let(:new_name)  { " " }
    before do
      fill_in "Full Name", with: new_name
    end
    it { should have_content("Edit Your Page") } 
    it { should have_content("can't be blank") } 
    specify { user.page.reload.name.should_not  == new_name }
  end

  describe "should display sidebar info" do
    it { should have_selector('a', :text => "Projects") }
    it { should have_selector('a', :text => "About Me") }
  end
end

describe "should be authorized" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "must be signed in" do
    before { visit edit_page_path(user.username) }
    it { should have_content('sign in') }
  end

  describe "logged out user submiting update action" do
    before { put page_path(user) }
    specify { response.should redirect_to(new_user_session_path) }
  end

  describe "as the wrong user" do 
    let(:wrong_user) { FactoryGirl.create(:user, username: "zorg", email: "zorg@zorg.com") }
    before { sign_in(user) }
      
    describe "visiting the edit page path" do
      before { visit edit_page_path(wrong_user) }
      it { should have_content('Login') } #redirected to the homepage
    end

    describe "submitting a put request to edit page path" do 
      before { put page_path(wrong_user) }
      specify { response.should redirect_to(new_user_session_path) }
    end
  end
end