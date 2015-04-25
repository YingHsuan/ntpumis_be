class BooksController < ApplicationController
  require 'ntpumis_logger'
  require 'utility'
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

  end
  def new
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @book = Book.new
    @book_type = BOOK_TYPE.as_json
    @book_type_category = BOOK_TYPE_CATEGORY.as_json puts @book_type_category
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
  private
  def book_params
    params.require(:book).permit(:title, :book_type, :book_type_category, :count, :edition, :book_author, :book_publisher, :thesis_id)
  end
end
