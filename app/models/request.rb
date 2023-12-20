class Request < ApplicationRecord
  belongs_to :user
  def save_with_request(title, systemid, authors, user_id)
    ActiveRecord::Base.transaction do
      self.title = title
      self.author = authors.first.strip
      self.isbn = systemid
      self.user_id = user_id
      self.save!
    end
    true
  rescue StandardError
    false
  end

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

end