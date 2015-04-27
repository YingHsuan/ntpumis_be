class BooksController < ApplicationController
  require 'ntpumis_logger'
  require 'utility'
  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  before_action :find_book, only:[:edit, :update, :destroy]
  BOOK_TYPE={
    :book => "書籍",
    :magazine => "雜誌",
    :thesis => "論文"
  }
  BOOK_TYPE_CATEGORY={
    :programming => "程式設計",
    :ecommerce => "電子商務",
    :other => "其他領域",
    :english => "英文"
  }
  def index
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @book_type_category = BOOK_TYPE_CATEGORY.as_json
    @book_arr = []
    @magazine_arr = []
    @thesis_arr = []
    books = Book.all
    books.each do |b|
      case b.book_type
        when 'book'
         @book_arr << b
        when 'magazine'
         @magazine_arr << b
        when 'thesis'
         @thesis_arr << b
      end
    end
  end
  def new
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @book = Book.new
    @book_type = BOOK_TYPE.as_json
    @book_type_category = BOOK_TYPE_CATEGORY.as_json
    # is thesis and not register in books
    @thesis = Thesis.where("(conference ='') and (NOT EXISTS(select * from books where books.thesis_id = theses.id))")
  end
  def create
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", params.to_s)
    @book = Book.new(book_params)
    @book.save

    redirect_to :action => :index
    flash[:notice] = "成功新增書籍 [#{BOOK_TYPE.as_json[@book.book_type]}] #{@book.title}"
  end
  def edit
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", params.to_s)
    @book_type = BOOK_TYPE.as_json
    @book_type_category = BOOK_TYPE_CATEGORY.as_json
    @thesis = Thesis.where("(conference ='') and (NOT EXISTS(select * from books where books.thesis_id = theses.id))")
  end
  def update
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", params.to_s)
    original_sn = @book.serial_no
    @book.update(book_params)
    #update borrow serial_no
    Borrow.where("book_serial_no = ?",original_sn).update_all(:book_serial_no => @book.serial_no)
    redirect_to :action => :index
    flash[:notice] = "成功更新書籍 [#{BOOK_TYPE.as_json[@book.book_type]}] #{@book.title}"
  end
  def destroy
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @book.destroy
    Borrow.destroy_all(:book_serial_no => @book.serial_no)
    redirect_to :action => :index
    flash[:alert] = "成功刪除書籍 #{@book.title}"
  end
  private
  def book_params
    params.require(:book).permit(:title, :book_type, :book_type_category, :count, :edition, :book_author, :book_publisher, :thesis_id)
  end
  def find_book
    @book = Book.find(params[:id])
  end
end
