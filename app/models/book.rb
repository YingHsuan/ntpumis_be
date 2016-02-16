class Book < ActiveRecord::Base
  require 'utility'
  before_save :default_values

  def default_values
    self.id =  SecureRandom.uuid
    case self.book_type
      when "book"
        self.serial_no = Utility.generate_book_sn(self.book_type_category,self.created_at.nil? ? DateTime.now().utc : self.created_at.utc)
      when "magazine"
        self.serial_no = Utility.generate_magazine_sn(self.edition,self.created_at.nil? ? DateTime.now().utc : self.created_at.utc)
      when "thesis"
        self.serial_no = Utility.generate_thesis_sn(self.thesis_id)
    end
  end
end
