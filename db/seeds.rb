# USERS
require 'csv'

User.destroy_all
Report.destroy_all
Study.destroy_all
Deployment.destroy_all
OtnArray.destroy_all
Tag.destroy_all
Retrieval.destroy_all

puts 'SETTING UP DEFAULT USER LOGIN'
ENV['WEB_ADMIN_PASSWORD'] ||= "default"
user = User.create! :name => "Kyle Wilcox", :email => 'kwilcox@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "admin", :approved => true
user.confirm!
puts 'New admin user created: ' << user.email << "/" << ENV['WEB_ADMIN_PASSWORD']

User.create! :name => "User 1", :email => 'user1@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "researcher", :approved => true
User.create! :name => "User 2", :email => 'user2@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => false
User.create! :name => "User 3", :email => 'user3@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "general", :approved => false
User.create! :name => "User 4", :email => 'user4@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "general", :approved => true
User.create! :name => "User 5", :email => 'user5@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :approved => false



# OTN_ARRAY
CSV.foreach("#{Rails.root}/lib/data/locations.csv", {:headers => true}) do |row|
  OtnArray.create!({
    :code => row['code'],
    :description => row["Description"],
    :waterbody => row["Waterbody"]
  })
end



# STUDIES
stm = Study.create! :code => "SMRSL",
                    :name => "Sea Lamprey Project",
                    :title => "Spatial distribution and abundance of adult sea lampreys during spawning migration through the St. Marys River",
                    :description => "The sea lamprey (Petromyzon marinus) is an invasive parasite in the Laurentian Great Lakes that has devastated native fish communities.  Control efforts (e.g., removal via trapping, pesticide application, and sterilization) have substantially reduced their negative effects on the ecosystem.  However, sea lamprey populations remain above target levels in Lake Huron.  The St. Marys River is Lake Huron's largest tributary and greatest source of parasitic sea lamprey.  Trapping there occurs at an upstream rapids area near the outflow of Lake Superior.  Population assessment and control may be improved by capturing lampreys closer to Lake Huron or in tributaries that are currently not trapped.  Our objectives are 1) to measure the fraction of the sea lamprey population that encounter and are captured in existing traps and 2) to determine if lampreys use distinct pathways during upstream migration through the lower river.  Up to 400 adult sea lampreys will be acoustically tagged and released in to the lower St. Marys River during spring spawning runs in 2010-2012.  A detailed movement history for each tagged lamprey will be collected using a network of 80 acoustic receivers (Vemco VR2W) in the St. Marys River and tributaries.",
                    :benefits => "Results should aid in the development of improved sea lamprey assessment and control methods in Great Lakes tributaries.",
                    :organizations => ["U.S. Geological Survey, Great Lakes Science Center", "Great Lakes Fishery Commission", "U.S. Fish and Wildlife Service, Marquette Biological Station","Department of Fisheries and Oceans Canada, Sea Lamprey Control Center"],
                    :funding => ["Greak Lakes Restoration Initiative"],
                    :url => "http://www.glfc.org/telemetry/sealamprey.php",
                    :start => Time.utc(2010,1,1),
                    :ending => Time.utc(2012,12,1),
                    :species => Fish::TYPES[3],
                    :user => User.create!(:name => "STM Admin 6", :email => 'user6@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true)

hec = Study.create! :code => "HEC",
                    :name => "Walleye Project",
                    :description => "Tracking Walleye movement between Lakes Huron and Erie",
                    :url => "http://www.glfc.org/telemetry/walleye.php",
                    :start => Time.utc(2009,1,1),
                    :ending => Time.utc(2010,12,31),
                    :species => Fish::TYPES[0],
                    :user => User.create!(:name => "HEC Admin 7", :email => 'user7@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true)

drm = Study.create! :code => "DRM",
                    :name => "Lake Trout Project",
                    :description => "Understanding spawning behavior of wild and hatchery-reared lake trout at the Drummond Island Lake Trout Refuge",
                    :url => "http://www.glfc.org/telemetry/laketrout.php",
                    :start => Time.utc(2010,1,1),
                    :ending => Time.utc(2012,12,31),
                    :species => Fish::TYPES[1],
                    :user => User.create!(:name => "DRM Admin 8", :email => 'user8@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true)

mrs = Study.create! :code => "MRS",
                    :name => "Lake Sturgeon Project",
                    :description => "Movement and Habitiat Use of Adult and Juvenile Lake Sturgeon in the Muskegon River System, Michigan",
                    :url => "",
                    :start => Time.utc(2010,1,1),
                    :ending => Time.utc(2012,12,1),
                    :species => Fish::TYPES[2],
                    :user => User.create!(:name => "MRS Admin 9", :email => 'user9@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true)

stm.user.confirm!
hec.user.confirm!
drm.user.confirm!
mrs.user.confirm!

# DEPLOYMENTS
CSV.foreach("#{Rails.root}/lib/data/deployment.csv", {:headers => true}) do |row|
  freq = row["FREQUENCY"].to_s.gsub("kHz","").strip
  freq = freq.empty? ? nil : freq
  Deployment.create!({
    :start => Time.strptime(row["DEPLOY_DATE_TIME"],"%m/%d/%Y").utc,
    :study_id => Study.find_by_code(row["GLATOS_STUDY"]).id,
    :location => "POINT(#{row['DEPLOY_LONG']} #{row['DEPLOY_LAT']})",
    :otn_array_id => OtnArray.find_by_code(row["OTN_ARRAY"]).id,
    :station => row["STATION_NO"].to_i,
    :model => row["INS_MODEL_NUMBER"],
    :seasonal => row["GLATOS_SEASONAL"] == "YES",
    :frequency => freq
  })
end

# RETRIEVALS
CSV.foreach("#{Rails.root}/lib/data/retrieval.csv", {:headers => true}) do |row|
  Retrieval.create!({
    :deployment => Deployment.find_by_otn_array_id_and_station(OtnArray.find_by_code(row["OTN_ARRAY"]).id,row["STATION_NO"]),
    :data_downloaded => row["DATA_DOWNLOADED"],
    :ar_confirm => row["AR_CONFIRM"],
    :recovered => Time.strptime(row["RECOVER_DATE_TIME"],"%m/%d/%Y").utc,
    :location => "POINT(#{row['RECOVER_LONG']} #{row['RECOVER_LAT']})"
  })
end

# TAGS
CSV.foreach("#{Rails.root}/lib/data/tag.csv", {:headers => true}) do |row|
  t = Tag.find_or_create_by_code_and_code_space_and_study_id(row["TAG_ID_CODE"], row["TAG_CODE_SPACE"], Study.find_by_code(row["GLATOS_STUDY"]).id)
  td = TagDeployment.create!({
    :common_name => Fish::TYPES.select{|s| /#{Regexp.escape(row["COMMON_NAME_E"].humanize)}/i.match(s)}.first,
    :release_location => row["RELEASE_LOCATION"],
    :release_date => Time.strptime(row["UTC_RELEASE_DATE_TIME"],"%m/%d/%Y").utc,
    :tag_id => t.id,
    :external_codes => [row["GLATOS_EXTERNAL_TAG_ID1"], row["GLATOS_EXTERNAL_TAG_ID2"]].compact.uniq
  })
end

# REPORTS
Report.create! :input_tag => Tag.first.code,
               :tag_deployment => TagDeployment.first,
               :description => "I found the tag in the water, under some other water.",
               :method => Report::METHODS.first,
               :address => "55 Village Square Drive",
               :zipcode => "55555",
               :name => "John the Fisherman",
               :phone => "401-029-0986",
               :email => "kwilcox@asascience.com",
               :city => "Some Town",
               :state => State::NAMES.first[1],
               :reported => Time.now.utc,
               :found => Time.now.utc - 1.week,
               :length => 23,
               :comments => "Fun fish to catch!",
               :fishtype => Fish::TYPES.first,
               :location => 'POINT(-122 47)',
               :didwith => "Ate it, yummy!"
