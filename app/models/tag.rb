class Tag < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_all,
                  :against => [:serial, :code, :code_space, :model, :manufacturer, :description],
                  :using => {
                    :tsearch => {:prefix => true},
                    :trigram => {}
                  }

  pg_search_scope :exact_match,
                  :against => [:serial, :code, :code_space],
                  :using => {
                    :tsearch => {:any_word => true}
                  }

  has_many      :tag_deployments, :dependent => :destroy

  belongs_to    :study

  validates_uniqueness_of   :code, :serial, :case_sensitive => false

  scope :find_match, lambda { |code| where("code ILIKE ? OR code_space ILIKE ?", "%#{code}%","%#{code}%").limit(1) }

  def active_deployment
    tag_deployments.order("release_date DESC").limit(1).first rescue nil
  end

  def active_deployment_json
    active_deployment.as_json({:only => [:release_date, :release_location, :external_codes, :length, :weight, :age, :sex, :common_name]})
  end

  def self.load_data(file = "#{Rails.root}/lib/data/old/tag.csv")
    require 'csv'
    CSV.foreach(file, {:headers => true}) do |row|
      deployed_time = Time.parse(row["UTC_RELEASE_DATE_TIME"] + " UTC"),
      woh_d = row["WILD_OR_HATCHERY"].downcase
      woh = woh_d == "w" ? "Wild" : who_d == "h" ? "Hatchery" : "Unknown"

      t = Tag.find_or_initialize_by_code_and_code_space_and_study_id(row["TAG_ID_CODE"], row["TAG_CODE_SPACE"], Study.find_by_code(row["GLATOS_PROJECT"]).id)
      t.update_attributes(
        {
          :model => row["TAG_MODEL"],
          :manufacturer => row["TAG_MANUFACTURER"],
          :serial => row["TAG_SERIAL_NUMBER"],
          :description => row["COMMENTS"],
          :type => row["TAG_TYPE"],
          :lifespan => "#{row["EST_TAG_LIFE"].split(" ")[0]} days",
          :endoflife => deployed_time.advance(:days => row["EST_TAG_LIFE"].split(" ")[0].to_i)
        }
      )
      td = TagDeployment.find_or_initialize_by_tag_id_and_release_date(t.id, deployed_time)
      td.update_attributes(
        {
          :tagger => row["TAGGER"],
          :common_name => Fish::TYPES.select{|s| /#{Regexp.escape(row["COMMON_NAME_E"].humanize)}/i.match(s)}.first,
          :scientific_name => Fish::SCITYPES.select{|s| /#{Regexp.escape(row["SCIENTIFIC_NAME"].humanize)}/i.match(s)}.first,
          :capture_location => row["CAPTURE_LOCATION"],
          :capture_geo => "POINT(#{row['CAPTURE_LONGITUDE']} #{row['CAPTURE_LATITUDE']})",
          :capture_depth => BigDecimal.new(row["CAPTURE_DEPTH"]),
          :capture_date => Time.parse(row["GLATOS_CAUGHT_DATE"] + "T00:00:00 UTC"),
          :wild_or_hatchery => woh,
          :stock => row["STOCK"],
          :dna_sample_taken => row["DNA_SAMPLE_TAKEN"].downcase == "yes" ? true : false,
          :treatment_type => row["TREATMENT_TYPE"],
          :temperature_change => BigDecimal.new(row["TEMPERATURE_CHANGE"]),
          :holding_temperature => BigDecimal.new(row["HOLDING_TEMPERATURE"]),
          :surgery_location => row["SURGERY_LOCATION"],
          :surgery_geo => "POINT(#{row['SURGERY_LONGITUDE']} #{row['SURGERY_LATITUDE']})",
          :surgery_date => Time.parse(row["DATE_OF_SURGERY"] + "T00:00:00 UTC"),
          :sedative => row["SEDATIVE"],
          :sedative_concentration => row["SEDATIVE_CONCENTRATION"],
          :anaesthetic => row["ANAESTHETIC"],
          :buffer => row["BUFFER"],
          :anaesthetic_concentration => row["ANAESTHETIC_CONCENTRATION"],
          :buffer_concentration_in_anaesthetic => row["BUFFER_CONCENTRATION_IN_ANAESTHETIC"],
          :anesthetic_concentration_in_recirculation => row["ANESTHETIC_CONCENTRATION_IN_RECIRCULATION"],
          :buffer_concentration_in_recirculation => row["BUFFER_CONCENTRATION_IN_RECIRCULATION"],
          :do => BigDecimal.new(row["DISSOLVED_OXYGEN"]),
          :description => row["COMMENTS"],
          :release_group => row["RELEASE_GROUP"],
          :release_location => row["RELEASE_LOCATION"],
          :release_geo => "POINT(#{row['RELEASE_LONGITUDE']} #{row['RELEASE_LATITUDE']})",
          :release_date => Time.parse(row["UTC_RELEASE_DATE_TIME"] + " UTC"),
          :external_codes => [row["GLATOS_EXTERNAL_TAG_ID1"], row["GLATOS_EXTERNAL_TAG_ID2"]].compact.uniq,
          :sex => row["SEX"],
          :age => row["AGE"],
          :weight => BigDecimal.new(row["WEIGHT"]),
          :length => BigDecimal.new(row["LENGTH"]),
          :length_type => row["LENGTH_TYPE"],
          :implant_type => row["TAG_IMPLANT_TYPE"],
          :reward => row["GLATOS_REWARD"]
        }
      )
    end
  end

end
#
# == Schema Information
#
# Table name: tags
#
#  id           :integer         not null, primary key
#  study_id     :integer         indexed
#  serial       :string(255)
#  code         :string(255)
#  code_space   :string(255)
#  lifespan     :string(255)
#  endoflife    :datetime
#  model        :string(255)     indexed
#  manufacturer :string(255)
#  type         :string(255)
#  description  :text
#
