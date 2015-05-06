require "capybara/rspec"
require "./app"
require "spec_helper"

Capybara.app = Sinatra::Application
set(:show_expectations, false)

describe('Loading the first page', {:type => :feature}) do
  it('Allows the user to see the index page') do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end
