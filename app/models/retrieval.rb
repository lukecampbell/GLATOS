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

