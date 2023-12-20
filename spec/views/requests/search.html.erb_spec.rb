require 'rails_helper'

require 'capybara/rspec'

RSpec.describe Request, type: :view do
  include Capybara::DSL
  it "リクエスト画面の操作" do

    user = FactoryBot.build(:user)
    visit search_requests_path
    fill_in 'search', with: 'パーフェクトRuby'
    click_on '検索する'
    # expect(page).to have_text '検索されました'

    click_on 'リクエストを送信', match: :first
    # expect(page).to have_text 'リクエストが送信されました'
  end
end