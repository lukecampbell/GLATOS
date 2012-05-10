class Study < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_all,
                  :against => [:code, :name, :description, :species, :benefits, :objectives, :organizations, :investigators, :funding],
                  :using => {
                    :tsearch => {:prefix => true},
                    :trigram => {}
                  },
                  :associated_against => {
                    :user =>  [ :name,
                                :organization,
                                :email
                              ]
                  }

  has_attached_file :img_first, :styles => { :medium => "360", :thumb => "75" }
  has_attached_file :img_second, :styles => { :medium => "360", :thumb => "75" }
  has_attached_file :img_third, :styles => { :medium => "360", :thumb => "75" }
  has_attached_file :img_fourth, :styles => { :medium => "360", :thumb => "75" }
  has_attached_file :img_fifth, :styles => { :medium => "360", :thumb => "75" }

  belongs_to  :user
  validates   :user, :presence => true
  accepts_nested_attributes_for :user


  has_many    :deployments, :dependent => :destroy

  has_many    :tags, :dependent => :destroy

  def organizations
    get_array(:organizations)
  end

  def organizations=(orgs)
    set_array(orgs, :organizations)
  end

  def objectives
    get_array(:objectives)
  end

  def objectives=(objs)
    set_array(objs, :objectives)
  end

  def funding
    get_array(:funding)
  end

  def funding=(funds)
    set_array(funds, :funding)
  end

  def benefits
    get_array(:benefits)
  end

  def benefits=(benefits)
    set_array(benefits, :benefits)
  end

  def investigators
    get_array(:investigators)
  end

  def investigators=(inves)
    set_array(inves, :investigators)
  end

  def get_array(sym)
    read_attribute(sym).split("=;=") rescue []
  end

  def set_array(setme, sym)
    if setme.is_a? String
      write_attribute(sym, setme)
    elsif setme.is_a? Array
      write_attribute(sym, setme.join("=;="))
    end
  end

  def self.clean_string(str)
    str.split(',',2)[-1].strip.chomp("\"").reverse.chomp("\"").reverse
  end

  def self.load_data(file)

    errors = []
    File.open(file) do |f|
      begin
        lines = f.readlines
        ENV['WEB_ADMIN_PASSWORD'] ||= "default"
        # Update or create a new PI user
        user_email = clean_string(lines[22]).downcase
        user = User.find_or_initialize_by_email(user_email)
        user.attributes =
          {
            :name => clean_string(lines[18])
          }

        # Set a password for a new user
        if user.new_record?
          user.attributes =
            {
              :password => ENV['WEB_ADMIN_PASSWORD'],
              :password_confirmation => ENV['WEB_ADMIN_PASSWORD'],
              :role => "investigator"
            }
        end
        unless user.valid?
          errors << "#{study.errors.full_messages.join(" and ")}"
        end

        code = clean_string(lines[2])
        study = Study.find_or_initialize_by_code(code)

        start_date = Date.parse(clean_string(lines[8])) rescue nil
        end_date = Date.parse(clean_string(lines[10])) rescue nil
        study.attributes =
          {
            :name => clean_string(lines[6]),
            :title => clean_string(lines[4]),
            :start => start_date,
            :ending => end_date,
            :description => clean_string(lines[12]),
            :objectives => clean_string(lines[14]),
            :investigators => clean_string(lines[24]),
            :organizations => clean_string(lines[26]),
            :funding => clean_string(lines[28]),
            :benefits => clean_string(lines[16]),
            :url => clean_string(lines[30]),
            :user => user
          }
        unless study.valid?
          errors << "#{study.errors.full_messages.join(" and ")}"
        end
      rescue Exception => e
        errors << "Error loading project: #{e}"
      end

      return user, study, errors

    end
  end

end
#
# == Schema Information
#
# Table name: studies
#
#  id                      :integer         not null, primary key
#  name                    :string(255)     not null
#  description             :text
#  start                   :datetime
#  ending                  :datetime
#  url                     :string(255)
#  species                 :string(255)
#  user_id                 :integer
#  code                    :string(20)      not null
#  title                   :text
#  benefits                :text
#  organizations           :text
#  funding                 :text
#  information             :text
#  objectives              :text
#  investigators           :text
#  img_first_file_name     :string(255)
#  img_first_content_type  :string(255)
#  img_first_file_size     :integer
#  img_first_updated_at    :datetime
#  img_second_file_name    :string(255)
#  img_second_content_type :string(255)
#  img_second_file_size    :integer
#  img_second_updated_at   :datetime
#  img_third_file_name     :string(255)
#  img_third_content_type  :string(255)
#  img_third_file_size     :integer
#  img_third_updated_at    :datetime
#  img_fourth_file_name    :string(255)
#  img_fourth_content_type :string(255)
#  img_fourth_file_size    :integer
#  img_fourth_updated_at   :datetime
#  img_fifth_file_name     :string(255)
#  img_fifth_content_type  :string(255)
#  img_fifth_file_size     :integer
#  img_fifth_updated_at    :datetime
#
