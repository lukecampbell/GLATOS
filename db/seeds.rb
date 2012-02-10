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
                    :name => "St Marys River Sea Lamprey Migration",
                    :title => "Spatial distribution and abundance of adult sea lampreys during spawning migration through the St. Marys River",
                    :description => "The sea lamprey (Petromyzon marinus) is an invasive parasite in the Laurentian Great Lakes that has devastated native fish communities.  Control efforts (e.g., removal via trapping, pesticide application, and sterilization) have substantially reduced their negative effects on the ecosystem.  However, sea lamprey populations remain above target levels in Lake Huron.  The St. Marys River is Lake Huron's largest tributary and greatest source of parasitic sea lamprey.  Trapping there occurs at an upstream rapids area near the outflow of Lake Superior.  Population assessment and control may be improved by capturing lampreys closer to Lake Huron or in tributaries that are currently not trapped.  Our objectives are 1) to measure the fraction of the sea lamprey population that encounter and are captured in existing traps and 2) to determine if lampreys use distinct pathways during upstream migration through the lower river.  Up to 400 adult sea lampreys will be acoustically tagged and released in to the lower St. Marys River during spring spawning runs in 2010-2012.  A detailed movement history for each tagged lamprey will be collected using a network of 80 acoustic receivers (Vemco VR2W) in the St. Marys River and tributaries.",
                    :benefits => "Results should aid in the development of improved sea lamprey assessment and control methods in Great Lakes tributaries.",
                    :organizations => ["U.S. Geological Survey, Great Lakes Science Center", "Great Lakes Fishery Commission", "U.S. Fish and Wildlife Service, Marquette Biological Station","Department of Fisheries and Oceans Canada, Sea Lamprey Control Center"],
                    :objectives => ["To measure the fraction of the sea laprey population that encounter and are captured in existings traps","To determine if lampreys use distinct pathways during upstream migration through the lower river"],
                    :funding => ["Greak Lakes Restoration Initiative"],
                    :url => "http://www.glfc.org/telemetry/sealamprey.php",
                    :start => Time.utc(2010,1,1),
                    :ending => Time.utc(2012,12,1),
                    :species => Fish::TYPES[3],
                    :user => User.create!(:name => "Chris Holbrook", :organization => 'U.S. Geological Survey, Hammond Bay Biological Station', :email => 'cholbrook@usgs.gov', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true),
                    :investigators => ["Charles Krueger (Great Lakes Fishery Commission)","Roger Bergstedt (U.S. Geological Survey)","Jessica Barber (U.S. Fish and Wildlife Service)","Rod MacDonald (Fisheries and Oceans Canada)"],
                    :img_first => File.open("#{Rails.root}/doc/project_images/SMRSL_1.jpg"),
                    :img_second => File.open("#{Rails.root}/doc/project_images/SMRSL_2.jpg")


hec = Study.create! :code => "HECWL",
                    :name => "Huron Erie Walleye Spatial Ecology",
                    :title => "Spatial ecology, migration and mortality of adult walleye in Lake Huron and western Lake Erie",
                    :description => "Across the Great Lakes walleye represent an important ecological and economic fish species.  Although the abundance of walleye varies among the different lakes, this species moves across large geographic areas within and among the Great Lakes.  Walleye have recently recovered in Saginaw Bay and now are a major predator in Lake Huron. Consequently, information regarding the migration patterns of Great Lakes walleye stocks as it pertains to fish age, sex and spawning population will provide fishery researchers with the information needed to better manage these populations and ensure that these populations persist into the future.  During the spring of 2011, fishery biologists with the Michigan Department of Natural Resources, Ohio Department of Natural Resources, Carleton University, and the Great Lakes Fishery Commission collected walleye from the Tittabawassee River, Lake Huron and Maumee River, Lake Erie during the annual spawning migration.  An acoustic transmitter was surgically implanted into the body cavity of two hundred walleye, 100 males and 100 females, from each river.  Walleye were also tagged with two external anchor tags to alert anglers and aid in the recovery of the tag.  Following the surgery walleyes were released. Movement patterns of these fish are being monitored using acoustic receivers located throughout the Tittabawassee and Maumee rivers, Lake Huron, and the Huron-Erie Corridor (Detroit and St. Clair rivers and Lake St. Clair) through 2014. Individuals catching or finding a walleye with an internal tag or external tag(s) are encouraged to report this information by filling out an electronic tag return form or calling 989-734-4768.",
                    :benefits => "This study will allow fisheries scientists to set system-specific harvest regulations designed to enhance and protect these populations, while maintaining appropriate levels of sustainable harvest.  The information will also allow fishery scientists to manage the overall predator consumption demand on Lake Huron's prey resources.",
                    :organizations => ["Great Lakes Fishery Commission","Carleton University","Ohio DNR","Michigan DNR","U.S. Geological Survey","Ontario Ministry of Natural Resources"],
                    :objectives => ["Determine the proportion of walleyes spawning in the Tittabawasse River or in the Maumee River that reside in the Lake Huron main basin population, move into and through the Huron-Erie-Corridor, and reside in Lake Erie.","Identify the environmental characteristics associated with the timing and extent of walleye movement from riverine spawning grounds into Lake Huron and back again.","Determine whether walleye demonstrate spawning site fidelity.","Compare unbiased estimates of mortality parameters of walleyes from Saginaw Bay and the Maumee River."],
                    :funding => ["Greak Lakes Restoration Initiative"],
                    :url => "http://www.glfc.org/telemetry/walleye.php",
                    :start => Time.utc(2010,6,1),
                    :ending => Time.utc(2014,12,1),
                    :species => Fish::TYPES[0],
                    :user => User.create!(:name => "John Dettmers", :organization => 'Great Lakes Fishery Commission', :email => 'jdettmers@glfc.org', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true),
                    :investigators => ["Chris Vandergoot (Ohio DNR)","Dave Fielder (Michigan DNR)","Steven Cooke (Carleton University)","Todd Hayden (Carleton University)","Chris Holbrook (U.S. Geological Survey)"],
                    :img_first => File.open("#{Rails.root}/doc/project_images/HECWL_1.jpg"),
                    :img_second => File.open("#{Rails.root}/doc/project_images/HECWL_2.jpg"),
                    :img_third => File.open("#{Rails.root}/doc/project_images/HECWL_3.jpg"),
                    :img_fourth => File.open("#{Rails.root}/doc/project_images/HECWL_4.jpg")

drm = Study.create! :code => "DRMLT",
                    :name => "Drummond Island lake trout spawning",
                    :title => "Reproductive behavior of wild and hatchery lake trout in the Drummond Island Refuge, Lake Huron",
                    :description => "Lake trout supported a valuable fisheries in the Great Lakes until the 1950s, when overfishing and sea lamprey predation resulted in the loss of most populations. Despite consistent stocking efforts since the 1960s, restoration of these populations has been slow. The reasons are numerous, but may be related to differences in spawning behavior between hatchery and wild trout. This study uses acoustic telemetry to describe and compare the spawning behaviors of wild and hatchery lake trout adjacent to Drummond Island, Lake Huron. Tagged fish are monitored by an array of approximately 150 acoustic hydrophones during the fall spawning season. Fish behavior data will be overlaid on detailed bathymetric and substrate data and compared with environmental variables (e.g., water temperature, wind speed and direction, and wave height and direction collected within the array by a Tidas 900 weather buoy) to develop a conceptual behavioral model. Sites suspected of being spawning habitats based on telemetry data will be verified through use of divers and trapping of eggs and fry.",
                    :benefits => "Our results will provide information critical to understanding how lake trout restoration efforts in the Great Lakes may be improved and to identifying management strategies for increasing the reproductive success of lake trout.  Determining whether lake trout reproductive success is limited by the habitat selection and behavior of spawning hatchery-reared lake trout will focus future research on areas that are likely to lead to successful lake trout restoration.",
                    :organizations => ["Great Lakes Fishery Commission","United States Geological Survey","United States Fish and Wildlife Service","Chippewa-Ottawa Resources Authority","Michigan Department of Natural Resources"],
                    :objectives => ["To compare the behaviors of spawning aggregations of wild and hatchery lake trout in terms of timing of arrival at spawning grounds, male-female aggregations, traveling over spawning areas, diel movements, and return rates to sites of previous spawning."," To describe and compare the environmental conditions associated with hatchery and wild lake trout behavior at time of spawning, specifically to determine whether differences in environmental conditions occur associated with behavioral expression.","To describe and compare the behavior of the two hatchery strains of lake trout stocked adjacent to the Drummond Island refuge to determine whether movement behaviors differ."],
                    :funding => ["Great Lakes Restoration Initiative"],
                    :url => "http://www.glfc.org/telemetry/laketrout.php",
                    :start => Time.utc(2010,8,1),
                    :ending => Time.utc(2014,8,1),
                    :species => Fish::TYPES[1],
                    :user => User.create!(:name => "Thomas Binder", :organization => 'Great Lakes Fishery Commission and Michigan State University', :email => 'tr.binder@gmail.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true),
                    :investigators => ["Charles Krueger (Great Lakes Fishery Commission)","Stephen Riley (U.S. Geological Survey)","Charles Bronte (U.S. Fish and Wildlife Service)","Mark Ebener (Chippewa Ottawa Resource Authority)","Chirstopher Holbrook (U.S. Geological Survey)","Ji He (Michigan DNR)","Roger Bergstedt (U.S. Geological Survey)"],
                    :img_first => File.open("#{Rails.root}/doc/project_images/DRMLT_1.jpg"),
                    :img_second => File.open("#{Rails.root}/doc/project_images/DRMLT_2.png"),
                    :img_third => File.open("#{Rails.root}/doc/project_images/DRMLT_3.jpg")

mrs = Study.create! :code => "MRS",
                    :name => "Lake Sturgeon Project",
                    :title => "",
                    :description => "Movement and Habitiat Use of Adult and Juvenile Lake Sturgeon in the Muskegon River System, Michigan",
                    :benefits => "",
                    :organizations => [],
                    :objectives => [],
                    :funding => [],
                    :url => "",
                    :start => Time.utc(2010,1,1),
                    :ending => Time.utc(2012,12,1),
                    :species => Fish::TYPES[2],
                    :user => User.create!(:name => "MRS Admin 9", :email => 'user9@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true),
                    :investigators => []

hst = Study.create! :code => "HECST",
                    :name => "Lake sturgeon metapopulation structure",
                    :title => "Lake sturgeon meta-population structure:  migration pathways, spawning fidelity, and survival in a complex river-lake ecosystem",
                    :description => "This study will use acoustic telemetry to describe the population spatial structure of lake sturgeon that spawn in the St. Clair and Detroit rivers in order to provide much needed information on habitat use by different sturgeon populations as well as on population-scale movements and dispersal patterns at ecologically-relevant temporal scales.  Spawning-condition adult lake sturgeon (> 120 cm total length) will be captured in the Detroit and St. Clair Rivers in 2012 and 2013, implanted with high-power acoustic tags with a battery life of 10 years, and then released near the capture site.  Strategically-located acoustic receivers in Lakes Erie, St. Clair, and Lake Huron, as well as in the Detroit and St. Clair Rivers will then allow scientists to track sturgeon movements between feeding, overwintering, and spawning grounds over thousands of square miles.  Application of study results could be used to infer that a number of separate sturgeon populations occur in Lake Michigan-Huron, Lake Erie, and Green Bay, rather than one large population.",
                    :benefits => "Results from this project may help managers to (1) spatially circumscribe units of management consideration for the Huron-Erie corridor (HEC), (2) assess the habitat area and configuration necessary to support healthy lake sturgeon populations, (3) inform the choice of sites for dam removal in other systems such as the Fox River, Wisconsin, (4) select sites for habitat preservation and/or enhancement, and (5) determine whether spatially explicit regulations should be considered to address conservation needs unique to groups of sturgeon identified by this project.",
                    :organizations => ["Great Lakes Fishery Commission","United States Geological Survey","United States Fish and Wildlife Service","Michigan Department of Natural Resources","Ontario Ministry of Natural Resources"],
                    :objectives => ["Determine whether dispersal of spawning-condition lake sturgeon in the Detroit and St. Clair rivers depends on release site (upper St. Clair R., lower St. Clair R., Detroit R.)","Determine if lake sturgeon return to rivers and sites of previous presumed spawning","Determine whether local populations defined by different dispersal patterns and spawning habitats survive at different rates and then determine if source-sink population dynamics are occurring among these populations"],
                    :funding => ["Great Lake Fishery Trust"],
                    :url => "",
                    :start => Time.utc(2012,1,1),
                    :ending => Time.utc(2017,12,31),
                    :species => Fish::TYPES[2],
                    :user => User.create!(:name => "Darryl W. Hondorp", :organization => 'United States Geological Survey, Great Lakes Science Center', :email => 'dhondorp@usgs.gov', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true),
                    :investigators => ["Charles Krueger (Great Lakes Fishery Commission)","Chris Holbrook (U.S. Geological Survey)","James Boase (U.S. Fish and Wildlife Service)","Michael Thomas (Michigan DNR)","Edward Roseman (U.S. Geological Survey)","Richard Drouin (Ontario MNR)"],
                    :img_first => File.open("#{Rails.root}/doc/project_images/HECST_1.jpg"),
                    :img_second => File.open("#{Rails.root}/doc/project_images/HECST_2.jpg")

dfo = Study.create! :code => "DFOWS",
                    :name => "Direct movement of nonindigenous fishes",
                    :title => "Evaluating the risk of direct movement of fishes through the Welland Canal and St. Marys River",
                    :description => "The Welland Canal has been identified as a pathway for direct (dispersal) and indirect (shipping) bi-directional movement of non-indigenous species (NIS) between Lake Ontario and the remaining Great Lakes, and the St. Marys River for movement of NIS between lakes Huron and Superior. Although substantial study is ongoing on the movement of NIS through the shipping vector, there has been virtually no study of the direct movement of NIS through these connections. Fishes of varying sizes and swimming abilities will be tagged internally, and their movement through these connections tracked by receivers placed throughout these systems. The occurrence of fishes in the lock chambers will be additionally assessed using remote hydroacoustics and a didson camera.",
                    :benefits => "This project will provide a better understanding of how NIS do, and could, use these connections to spread from one Great Lakes basin to another. This understanding is critical to the evaluation management options to prevent the spread of NIS between basins.",
                    :organizations => ["St. Lawrence Seaway Commission","Ontario Invasive Species Centre","GLFC (didson camera loan)"],
                    :objectives => ["To determine if fishes, including NIS, directly move between the Lake Ontario and Erie basins through the Welland Canal, and through the St. Marys River between Lake Superior and Huron basins using four types of water structures - locks, overflow channels, control gates, and the power generation network. H1: Locks will differentially facilitate fish movement from between basins; control gates and overflow channels will facilitate fish movement in both directions; and, the power generation network will minimize fish movement in both directions."],
                    :funding => ["Fisheries and Oceans Canada","Ontario Invasive Species Centre"],
                    :url => "",
                    :start => Time.utc(2011,4,1),
                    :ending => Time.utc(2016,4,1),
                    :species => "",
                    :user => User.create!(:name => "Nicholas Mandrak", :organization => 'Fisheries and Oceans Canada', :email => 'nicholas.mandrak@dfo-mpo.gc.ca', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => true),
                    :investigators => ["Thomas Pratt (Fisheries and Oceans Canada)","Marten Koops (Fisheries and Oceans Canada)"],
                    :img_first => File.open("#{Rails.root}/doc/project_images/DFOWS_1.jpg"),
                    :img_second => File.open("#{Rails.root}/doc/project_images/DFOWS_2.jpg"),
                    :img_third => File.open("#{Rails.root}/doc/project_images/DFOWS_3.jpg"),
                    :img_fourth => File.open("#{Rails.root}/doc/project_images/DFOWS_4.jpg")

stm.user.confirm!
hec.user.confirm!
drm.user.confirm!
mrs.user.confirm!
hst.user.confirm!
dfo.user.confirm!

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
               :tag_deployment => Tag.first.active_deployment,
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
