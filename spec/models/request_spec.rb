require 'rails_helper'


# expect(実行結果).to eq 期待する結果

RSpec.describe Request, type: :model do
  it "リクエストを送ると保存できること" do

    request = FactoryBot.create(:request)

    result = request.save_with_request(request.title, request.isbn, request.author, request.user_id)

    # # データベースに保存されていることを確認
    expect(result).to be_truthy
    expect(Request.count).to eq(1)

    saved_request = Request.first
    expect(saved_request.title).to eq(request.title)
    expect(saved_request.isbn).to eq(request.isbn)
    expect(saved_request.author).to eq(request.author)
    expect(saved_request.user_id).to eq(request.user.id)
  end
end