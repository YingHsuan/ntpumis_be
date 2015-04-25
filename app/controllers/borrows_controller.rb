class BorrowsController < ApplicationController
  require 'ntpumis_logger'
  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  def index
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", params.to_s)
  end
  def new
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", params.to_s)
    @borrow = Borrow.new
    @students = Student.where("is_graduated = ?",false)
    @teachers = Teacher.all
    @book_arr = []
    @magazine_arr = []
    @thesis_arr = []
    books = Book.where("count > 0")
    books.each do |b|
      case b.book_type
      when "book"
        @book_arr << b
      when "magazine"
        @magazine_arr << b
      when "thesis"
        @thesis_arr << b
      end
    end
  end
  def create
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", params.to_s)
    borrow = Borrow.new
    borrow.book_serial_no = params[:book_serial_no]
    borrow.borrower_type = params[:borrower_type]
    borrow.borrower_id = params[:borrower_id]
    borrow.borrow_date = DateTime.now()
    borrow.is_return = false
    borrow.save!

    book = Book.find_by_serial_no(params[:book_serial_no])
    book.count = (book.count - 1)
    book.save!
    redirect_to :action => :index
    flash[:notice] = "成功借閱書籍 #{book.title}"
  end
end
