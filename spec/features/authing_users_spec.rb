require "rails_helper"

RSpec.feature "Authenticating", type: :feature do
  let(:user) { create(:user, email: "crazyperson@saaliklok.com", password: "password") }

  scenario "User signs up for Scribble" do
    visit new_user_registration_path

    fill_in "Email", with: "superscribbler@lokbros.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"

    expect(current_path).to eq(root_path)
  end

  scenario "User logs into Scribble" do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    click_button "Log in"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed in successfully.")
  end
end
