class Book < ApplicationRecord
  has_one :lending, -> { where(return_status: false) }
  has_many :lendings, dependent: :destroy
  has_many :lend_active, -> { where(return_status: false) }, class_name: 'Lending'
  has_many :reservations
  has_many :reservation_active, -> { where(reservation_at: Date.today..Float::INFINITY)}, class_name: 'Reservation'
  has_one_attached :image

  validates :title, presence: true

  delegate :created_at, :return_at, :user, to: :lending

  scope :available_books, -> { eager_load(:lendings).where(lendings: { return_status: true }).or(where(lendings: { id: nil}))}

  def status_user(user)
    user_id = user&.id
    lending_status = lend_active.any?{ |lending| lending.user_id == user_id }
    reservation_status = reservation_active.any?{ |reservation| reservation.user_id == user_id }
    if lending_status && user_id.present?
      "lending"
    elsif reservation_status && user_id.present?
      "reserved"
    elsif lend_active.present?
      "lent"
    else
      "available"
    end
  end

  def self.ransackable_scopes(auth_object = nil)
    [:available_books]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["isbn", "title"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["lendings"]
  end
end

books = Book.all.includes(:lendings)

booklend =[]

books.each do |book|
  lending = book.lending
  if lending.nil? || lending.return_status
    booklend << book.id
  end
end