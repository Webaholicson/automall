require 'rails_helper'

describe "possible account actions" do
  it "signs user in" do
    User.create(
      :first_name => 'John',
      :last_name => 'Doe',
      :email => 'user@example.com',
      :password => Digest::MD5.hexdigest(Base64.encode64('password'))
    )

    visit '/account/login'
    within("#login-form") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Login'
    expect(page).to have_content 'Dashboard'
    expect(page).to have_xpath '//li[contains(.//a/text(), "Logout")]'
  end

  it "tries to login without entering credentials" do
    visit '/account/login'
    click_button 'Login'
    expect(page).to have_content I18n.t :invalid_user
  end

  it "registers the user" do
    visit '/account/register'
    within("#registration-form") do
      fill_in 'First Name', :with => 'Jane'
      fill_in 'Last Name', :with => 'Doe'
      fill_in 'Email', :with => 'jane@example.com'
      fill_in 'Email Confirmation', :with => 'jane@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Register'
    expect(page).to have_content I18n.t :user_was_registered
  end

  it "tries to access my account page while logged out" do
    visit '/account/dashboard'
    expect(page).to have_content I18n.t :must_login
  end
end
