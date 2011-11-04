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
User.create! :name => "User 3", :email => 'user3@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "public", :approved => false
User.create! :name => "User 4", :email => 'user4@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "public", :approved => true
User.create! :name => "User 5", :email => 'user5@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :approved => false



# OTN_ARRAY
otns = ["BBI","BLL","BRS","BWA","BWB","CHR","CKI","DCK","DRM","DTR","EDS","FDT","FMP","GRD","GRS","IS1","LRC","LRP","LVD","LVU","MAU","MNB","OSC","OVP","PCH","PRS","RNS","RTR","RVR","SBI","SBO","SGR","SIC","SQR","SSM","STG","STR","THB","TRN","TTB","URC","WHT"]
otns.each do |c|
  OtnArray.create({:code => c})
end

# STUDIES
stm = Study.create! :name => "STM",
                    :description => "Tracking Sea Lamprey migration through the St. Marys River",
                    :url => "http://www.glfc.org/telemetry/sealamprey.php",
                    :start => Time.utc(2010,1,1),
                    :end => Time.utc(2012,12,1),
                    :species => Fish::TYPES[3]

hec = Study.create! :name => "HEC",
                    :description => "Tracking Walleye movement between Lakes Huron and Erie",
                    :url => "http://www.glfc.org/telemetry/walleye.php",
                    :start => Time.utc(2009,1,1),
                    :end => Time.utc(2010,12,31),
                    :species => Fish::TYPES[0]

drm = Study.create! :name => "DRM",
                    :description => "Understanding spawning behavior of wild and hatchery-reared lake trout at the Drummond Island Lake Trout Refuge",
                    :url => "http://www.glfc.org/telemetry/laketrout.php",
                    :start => Time.utc(2010,1,1),
                    :end => Time.utc(2012,12,31),
                    :species => Fish::TYPES[1]

#DEPLOYMENTS
CSV.foreach("#{Rails.root}/lib/data/deployment.csv", {:headers => true}) do |row|
  Deployment.create!({
    :start => Time.strptime(row[7],"%m/%d/%Y"),
    :study_id => Study.find_by_name(row[row.length- 1]).id,
    :location => "POINT(#{row[9]} #{row[8]})",
    :otn_array_id => OtnArray.find_by_code(row[1]).id,
    :station => row[2].to_i,
    :model => row["INS_MODEL_NUMBER"],
    :seasonal => row["GLATOS_STUDY"] == "YES"
  })
end


#TAGS
CSV.foreach("#{Rails.root}/lib/data/tag.csv", {:headers => true}) do |row|
  t = Tag.find_or_create_by_code_and_code_space_and_study_id(row[6], row[7], Study.find_by_name(row[row.length - 1]).id)
  td = TagDeployment.create!({
    :common_name => Fish::TYPES.select{|s| /#{Regexp.escape(row[14].humanize)}/i.match(s)}.first,
    :release_location => row[29],
    :release_date => Time.strptime(row[32],"%m/%d/%Y"),
    :tag_id => t.id
  })
end

# REPORTS
Report.create! :tag => "ABC123",
               :description => "I found the tag in the water, under some other water.",
               :method => Report::METHODS.first,
               :name => "John the Fisherman",
               :phone => "401-029-0986",
               :email => "kwilcox@asascience.com",
               :city => "Some Town",
               :state => State::NAMES.first[1],
               :reported => Time.now.utc,
               :found => Time.now.utc - 1.week,
               :length => 23,
               :weight => 30,
               :fishtype => Fish::TYPES.first,
               :location => 'POINT(-122 47)'
