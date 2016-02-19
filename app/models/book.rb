class Book < ActiveRecord::Base
  require 'utility'
  before_save :default_values

  def default_values
    self.id =  SecureRandom.uuid
    case self.book_type
      when "book"
<<<<<<< Updated upstream
        self.serial_no = Utility.generate_book_sn(self.book_type_category,self.created_at.nil? ? Time.now().utc : self.created_at.utc)
||||||| merged common ancestors
        self.serial_no = Utility.generate_book_sn(self.book_type_category,self.created_at.nil? ? DateTime.now() : self.created_at)
=======
        self.serial_no = Utility.generate_book_sn(self.book_type_category,self.created_at.nil? ? DateTime.now().utc : self.created_at.utc)
>>>>>>> Stashed changes
      when "magazine"
<<<<<<< Updated upstream
        self.serial_no = Utility.generate_magazine_sn(self.edition,self.created_at.nil? ? Time.now().utc : self.created_at.utc)
||||||| merged common ancestors
        self.serial_no = Utility.generate_magazine_sn(self.edition,self.created_at.nil? ? DateTime.now() : self.created_at)
=======
        self.serial_no = Utility.generate_magazine_sn(self.edition,self.created_at.nil? ? DateTime.now().utc : self.created_at.utc)
>>>>>>> Stashed changes
      when "thesis"
        self.serial_no = Utility.generate_thesis_sn(self.thesis_id)
    end
  end
end
