class OtnArray < ActiveRecord::Base

  has_many :deployments

  validates_presence_of :code

  def self.load_data(file = "#{Rails.root}/lib/data/old/locations.csv")
    require 'csv'
    otns = []
    errors = []
    CSV.foreach(file, {:headers => true}) do |row|
      o = OtnArray.find_or_initialize_by_code(row['GLATOS_ARRAY'])
      o.attributes =
        {
          :description => row["LOCATION_DESCRIPTION"],
          :waterbody => row["WATER_BODY"],
          :region => row["GLATOS_REGION"]
        }
      if o.valid?
        otns << o
      else
        errors << "#{o.errors.full_messages.join(" and ")} - Data: #{row}"
      end
    end
    return otns, errors
  end

end
#
# == Schema Information
#
# Table name: otn_arrays
#
#  id          :integer         not null, primary key
#  code        :string(255)     indexed
#  description :text
#  waterbody   :string(255)
#  region      :string(255)
#
