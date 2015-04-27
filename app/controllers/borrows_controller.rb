class BorrowsController < ApplicationController
  require 'ntpumis_logger'
  before_action :authenticate_user!, only: [:new, :index, :return_book]
  def index
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", params.to_s)
    @borrow_unreturn = []
    @borrow_returned = []
    borrows = Borrow.all
    borrows.each do |b|
      bookSN = b.book_serial_no
      bookName = Book.find_by_serial_no(bookSN).nil? ? nil : Book.find_by_serial_no(bookSN).title
      if b.borrower_type == "student"
        borrowerName = Student.find_by_id(b.borrower_id).stu_name
      elsif b.borrower_type == "teacher"
        borrowerName = Teacher.find_by_id(b.borrower_id).name_c
      end

      case b.is_return
      when true
        @borrow_returned.push(
          {
            :id => b.id,
            :borrower_name => borrowerName,
            :book_serial_no => bookSN,
            :book_name => bookName,
            :borrow_date => b.borrow_date.strftime("%Y/%m/%d"),
            :return_date => b.return_date.nil? ? '':b.return_date.strftime("%Y/%m/%d")

          }
        )
      when false
        @borrow_unreturn.push(
          {
            :id => b.id,
            :borrower_name => borrowerName,
            :book_serial_no => bookSN,
            :book_name => bookName,
            :borrow_date => b.borrow_date.strftime("%Y/%m/%d")

          }
        )
      end
    end
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
  def return_book
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", params.to_s)
    puts params[:id]
    if params[:id].nil?
      redirect_to :action => :index
      flash[:alert] = "無此編號"
    else
      borrow_id = params[:id]
      borrow = Borrow.find_by_id(borrow_id)
      borrow.return_date = DateTime.now()
      borrow.is_return = true
      borrow.save!

      book = Book.find_by_serial_no(borrow.book_serial_no)
      book.count = (book.count + 1)
      book.save!
      redirect_to :action => :index
      flash[:notice] = "成功歸還 #{book.title}"
    end
  end
end
