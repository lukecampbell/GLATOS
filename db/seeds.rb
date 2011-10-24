puts 'SETTING UP DEFAULT USER LOGIN'
ENV['WEB_ADMIN_PASSWORD'] ||= "default"
user = User.create! :name => "Kyle wilcox", :email => 'kwilcox@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "admin", :approved => true
user.confirm!
puts 'New user created: ' << user.email << "/" << ENV['WEB_ADMIN_PASSWORD']


# Sample Reports

  validates :tag, :description, :method, :name, :phone, :email, :city, :state, :reported, :height, :weight, :fishtype, :found

Report.create! :tag => "ABC123",
               :description => "I found the tag in the water, under some other water.",
               :method => "Bait and tackle",
               :name => "John the Fisherman",
               :phone => "401-029-0986",
               :email => "kwilcox@asascience.com",
               :city => "Ann Arbour",
               :state => "Michigan",
               :reported => Time.now.utc,
               :found => Time.now.utc - 1.week,
               :length => 23,
               :weight => 30,
               :fishtype => Fish::TYPES.first,
               :location => 'POINT(-122 47)'
