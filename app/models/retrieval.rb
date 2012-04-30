class Retrieval < ActiveRecord::Base

  belongs_to :deployment

  validates :deployment_id, :presence => true

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))

  def geo
    return RGeo::GeoJSON.encode(self.location)
  end

  def geojson
    removals = ["location","id","deployment_id"]
    s = self.attributes.delete_if {|key, value| removals.include?(key) }
    feat = RGeo::GeoJSON::Feature.new(self.location, self.id, s)
    RGeo::GeoJSON.encode(feat)
  end

  def latitude(round=3)
    location.latitude.round(round)
  end

  def longitude(round=3)
    location.longitude.round(round)
  end

  def self.load_data(file = "#{Rails.root}/lib/data/old/retrieval.csv")
    require 'csv'
    CSV.foreach(file, {:headers => true}) do |row|
      otna = OtnArray.find_by_code(row["GLATOS_ARRAY"])
      return "No OtnArray with the code #{row["GLATOS_ARRAY"]}" unless otna
      dep = Deployment.find_by_otn_array_id_and_station_and_consecutive(otna.id, row["STATION_NO"].to_i, row["CONSECUTIVE_DEPLOY_NO"].to_i)
      return "No Deployment found for the retrival" unless dep
      ret = Retrieval.find_or_initialize_by_deployment_id(dep.id)
      ret.update_attributes(
        {
          :data_downloaded => row["DATA_DOWNLOADED"],
          :ar_confirm => row["AR_CONFIRM"],
          :recovered => Time.parse(row["RECOVER_DATE_TIME"] + " UTC"),
          :location => "POINT(#{row['RECOVER_LONG']} #{row['RECOVER_LAT']})"
        }
      )
    end
  end

end
#
# == Schema Information
#
# Table name: retrievals
#
#  id              :integer         not null, primary key
#  deployment_id   :integer         indexed
#  data_downloaded :boolean
#  ar_confirm      :boolean
#  recovered       :datetime
#  location        :spatial({:srid= indexed
#
