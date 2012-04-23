class Submission < ActiveRecord::Base

  belongs_to :user

  has_attached_file :spreadsheet, {
    :url => "#{ActionController::Base.relative_url_root}/system/:class/:attachment/:id/:style/:basename.:extension",
  }

  validates_presence_of :user

  validates_attachment_presence :spreadsheet
  validates_attachment_content_type :spreadsheet, :content_type => 'application/vnd.ms-excel.sheet.macroEnabled.12'

  def DT_RowId
    self.id
  end

  def spreadsheet_url
    self.spreadsheet.url
  end

  def status=(status)
    write_attribute(:status,status.downcase)
  end

end
