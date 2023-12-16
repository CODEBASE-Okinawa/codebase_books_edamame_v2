class BooksController < ApplicationController
  before_action :redirect_to_admin_books, only: [:index]
  before_action :redirect_to_sign_in, only: %i[show], unless: :user_signed_in?

  def index
    @books = Book.eager_load(:reservation_active, :lend_active).with_attached_image.order(:id)
  end

  def show
    @book = Book.find(params[:id])
    lending = @book.lendings.where(return_status: false, user_id: current_user.id).first
    redirect_to lending_path(lending) and return if lending
    reservation = @book.reservations.where("reservation_at >= ?", Time.now).where(user_id: current_user.id).first
    redirect_to reservation_path(reservation) if reservation
    @reservations = @book.reservations.where("reservation_at >= ?", Time.now).order(reservation_at: :asc)
  end

  private

  def redirect_to_admin_books
    return unless current_user&.admin?

    redirect_to admin_books_path
  end

end
