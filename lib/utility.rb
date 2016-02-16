class Utility
  def self.generate_book_sn(book_type_category,created_at)
    param1 = created_at.localtime.strftime("%Y%m%d%H%M")
    param2 = book_short_code(book_type_category)
    serial_no = "BOK-#{param1}-#{param2}"
    puts "book sn #{serial_no}"
    serial_no
  end
  def self.generate_magazine_sn(edition,created_at)
    param1 = created_at.localtime.strftime("%Y%m%d%H%M")
    param2 = edition
    serial_no = "MAG-#{param1}-#{param2}"
    puts "magazine sn #{serial_no}"
    serial_no
  end
  def self.generate_thesis_sn(thesis_id)
    student = Student.find_by_id(Thesis.find_by_id(thesis_id).student_id)
    serial_no = "THS-#{student.grade}-#{student.stu_no}"
    puts "thesis sn #{serial_no}"
    serial_no
  end
  def self.book_short_code(book_type_category)
    list={
      :programming => "1",
      :ecommerce => "2",
      :other => "3",
      :english => "4"
      }.as_json
    list[book_type_category]
  end

end
