class Deployment < ActiveRecord::Base
  require 'rgeo/geo_json'
  include PgSearch

  pg_search_scope :search_all,
                  :against => [:model],
                  :using => {
                    :tsearch => {:prefix => true},
                    :trigram => {}
                  },
                  :associated_against => {
                    :otn_array => [ :code,
                                    :description,
                                    :waterbody
                                  ]
                  }

  belongs_to :study
  belongs_to :otn_array
  has_one :retrieval, :dependent => :destroy

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))

  def DT_RowId
    self.id
  end

  def station
    "%03d" % read_attribute(:station) rescue nil
  end

  def rcv_modem_address
    "%03d" % read_attribute(:rcv_modem_address) rescue nil
  end

  def code
    "#{otn_array.code}-#{station}"
  end

  def geo
    return RGeo::GeoJSON.encode(self.location)
  end

  def geojson
    removals = ["location","id","station","otn_array_id"]
    s = self.attributes.delete_if {|key, value| removals.include?(key) }
    s[:code] = code
    s[:recovered] = ending
    s[:otn_array] = {:code => otn_array.code, :description => otn_array.description, :waterbody => otn_array.waterbody, :region => otn_array.region}
    feat = RGeo::GeoJSON::Feature.new(self.location, self.id, s)
    RGeo::GeoJSON.encode(feat)
  end

  def latitude(round=3)
    location.latitude.round(round)
  end

  def longitude(round=3)
    location.longitude.round(round)
  end

  def ending
    unless proposed
      return retrieval.recovered rescue nil
    else
      return proposed_ending
    end
  end

  def self.load_data(file = "#{Rails.root}/lib/data/old/deployment.csv")
    require 'csv'
    CSV.foreach(file, {:headers => true}) do |row|
      otna = OtnArray.find_by_code(row["GLATOS_ARRAY"])
      return "No OtnArray with the code #{row["GLATOS_ARRAY"]}" unless otna
      d = Deployment.find_or_initialize_by_otn_array_id_and_station_and_consecutive(otna.id, row["STATION_NO"].to_i, row["CONSECUTIVE_DEPLOY_NO"].to_i)
      d.update_attributes(
        {
          :start => Time.parse(row["DEPLOY_DATE_TIME"] + " UTC"),
          :study_id => Study.find_by_code(row["GLATOS_PROJECT"]).id,
          :location => "POINT(#{row['DEPLOY_LONG']} #{row['DEPLOY_LAT']})",
          :model => row["INS_MODEL_NUMBER"],
          :seasonal => row["GLATOS_SEASONAL"].downcase == "yes",
          :frequency => row["GLATOS_INS_FREQUENCY"].to_i,
          :riser_length => row["RISER_LENGTH"].to_i,
          :bottom_depth => row["BOTTOM_DEPTH"].to_i,
          :instrument_depth => row["INSTRUMENT_DEPTH"].to_i,
          :instrument_serial => row["INS_SERIAL_NO"],
          :rcv_modem_address => row["RCV_MODEM_ADDRESS"].to_i,
          :deployed_by => row["DEPLOYED_BY"],
          :vps => row["GLATOS_VPS"].downcase == "yes",
          :funded => true,
          :proposed => false,
          :proposed_ending => nil
        }
      )
    end
  end

  def self.load_proposed_data(file =  "#{Rails.root}/lib/data/old/proposed.csv")
    require 'csv'
    CSV.foreach(file, {:headers => true}) do |row|
      otna = OtnArray.find_by_code(row["GLATOS_ARRAY"])
      return "No OtnArray with the code #{row["GLATOS_ARRAY"]}" unless otna
      d = Deployment.find_or_initialize_by_otn_array_id_and_station_and_proposed(otna.id, row["STATION_NO"].to_i, true)
      d.update_attributes(
        {
          :consecutive => nil,
          :proposed_ending => Time.parse(row["PROPOSED_END_DATE"] + "T00:00:00 UTC"),
          :funded => row["GLATOS_FUNDED"].downcase == "yes",
          :start => Time.parse(row["PROPOSED_START_DATE"] + "T00:00:00 UTC"),
          :study_id => Study.find_by_code(row["GLATOS_PROJECT"]).id,
          :location => "POINT(#{row['PROPOSED_LONG']} #{row['PROPOSED_LAT']})",
          :seasonal => row["GLATOS_SEASONAL"].downcase == "yes",
          :frequency => row["GLATOS_INS_FREQUENCY"].to_i,
          :bottom_depth => row["BOTTOM_DEPTH"].to_i,
          :vps => row["GLATOS_VPS"].downcase == "yes"
        }
      )
    end
  end
end

#
# == Schema Information
#
# Table name: deployments
#
#  id                :integer         not null, primary key
#  start             :datetime
#  study_id          :integer
#  location          :spatial({:srid= indexed
#  otn_array_id      :integer
#  station           :integer
#  model             :string(255)
#  seasonal          :boolean
#  frequency         :integer
#  riser_length      :integer
#  bottom_depth      :integer
#  instrument_depth  :integer
#  instrument_serial :string(255)
#  rcv_modem_address :integer
#  deployed_by       :string(255)
#  vps               :boolean
#  consecutive       :integer
#

