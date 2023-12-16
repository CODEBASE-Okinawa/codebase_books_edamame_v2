ActiveRecord::Base.transaction do
  
  Book.create!(
      title:"プロを目指す人のためのRuby入門 言語仕様からテスト駆動開発・デバッグ技法まで",
      isbn:"4774193976"
    )

  Book.create!(
    title:"現場で使える Ruby on Rails 5速習実践ガイド", 
    isbn:"483996222"
  )

  Book.create!(
    title:"ゼロからわかる Ruby 超入門", 
    isbn:"4297101238"
  )

  Book.create!(
    title:"改訂2版 パーフェクトRuby", 
    isbn:"4774189774"
  )

  Book.create!(
    title:"達人が教えるWebパフォーマンスチューニング 〜ISUCONから学ぶ高速化の実践", 
    isbn:"4297128462"
  )


  User.create!(
    name: "admin",
    email: "admin@example.com",
    password: "password",
    password_confirmation: "password",
    role: 0
  )

  3.times do |n|
    User.create!(
      name: "テストユーザー#{n + 1}",
      email: "test#{n + 1}@example.com",
      password: "password",
      password_confirmation: "password",
      role: 1
    )
  end

  user = User.find_by(email: "test1@example.com")

  3.times do |n|
    user.reservations.create!(
      book_id: n + 1,
      reservation_at: Time.now + (n + 1).days,
      return_at: Time.now + (n + 7).days
    )
  end

  2.times do |n|
    if n.even?
      user.lendings.create!(
        book_id: n + 1,
        return_at: Date.today.days_since(n)
      )
    else
      user.lendings.create!(
        book_id: n + 1,
        return_at: Date.today.days_ago(n),
        return_status: true
      )
    end
  end

  Request.create!(
    title:"プロを目指す人のためのRuby入門 言語仕様からテスト駆動開発・デバッグ技法まで",
    author:"伊藤 淳一 ",
    isbn:"4774193976",
    status: false,
    user_id: user.id
  )

  Request.create!(
    title:"現場で使える Ruby on Rails 5速習実践ガイド", 
    author:"大場寧子",
    isbn:"483996222",
    status: false,
    user_id: user.id
  )

  Request.create!(
    title:"ゼロからわかる Ruby 超入門", 
    author:"五十嵐邦明",
    isbn:"4297101238",
    status: false,
    user_id: user.id
  )

  Request.create!(
    title:"怪物に出会った日 井上尚弥と闘うということ", 
    author:"森合 正範",
    isbn:"4065337488",
    status: true,
    user_id: user.id
  )

  Request.create!(
    title:"大ピンチずかん", 
    author:"鈴木 のりたけ",
    isbn:"4097251384",
    status: true,
    user_id: user.id
  )

end
