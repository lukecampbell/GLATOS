# USERS
require 'csv'

User.destroy_all
Report.destroy_all
Study.destroy_all
Deployment.destroy_all
OtnArray.destroy_all
Tag.destroy_all

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
    :description => row["Description"]
  })
end



# STUDIES
stm = Study.create! :code => "STM",
                    :name => "Sea Lamprey Project",
                    :description => "Tracking Sea Lamprey migration through the St. Marys River",
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
  Deployment.create!({
    :start => Time.strptime(row[7],"%m/%d/%Y"),
    :study_id => Study.find_by_code(row[row.length- 1]).id,
    :location => "POINT(#{row[9]} #{row[8]})",
    :otn_array_id => OtnArray.find_by_code(row[1]).id,
    :station => row[2].to_i,
    :model => row["INS_MODEL_NUMBER"],
    :seasonal => row["GLATOS_STUDY"] == "YES"
  })
end


# TAGS
CSV.foreach("#{Rails.root}/lib/data/tag.csv", {:headers => true}) do |row|
  t = Tag.find_or_create_by_code_and_code_space_and_study_id(row[6], row[7], Study.find_by_code(row[row.length - 1]).id)
  td = TagDeployment.create!({
    :common_name => Fish::TYPES.select{|s| /#{Regexp.escape(row[14].humanize)}/i.match(s)}.first,
    :release_location => row[29],
    :release_date => Time.strptime(row[32],"%m/%d/%Y"),
    :tag_id => t.id
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
