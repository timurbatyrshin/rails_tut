require 'spec_helper'
require 'ruby-debug'

describe "Authentication" do

  subject { page }


  describe "signin page" do
    before { visit signin_path }

    it { should have_header('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid credentials" do
      before { click_button "Sign in" }
      it { should have_title('Sign in') }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_error_message('Invalid') }
      end
    end

    describe "with valid credentials" do
      let(:user) { FactoryGirl.create(:user) }

      before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should_not have_error_message('Invalid') }
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "and then signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end

 describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end
end
