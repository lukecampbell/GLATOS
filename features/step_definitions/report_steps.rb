Given /^I fill in a valid report$/ do

  Given %{I fill in "Full Name" with "Kyle Wilcox"}
  And %{I fill in "Address" with "55 Village Square Drive"}
  And %{I fill in "City" with "South Kingstown"}
  And %{I fill in "Telephone" with "555-555-5555"}
  And %{I fill in "Email" with "report_submitted@glatos.org"}
  And %{I fill in "Fish Length" with "20"}
  And %{I fill in "Zip Code" with "55555"}
  And %{I select "Michigan" from "State/Province"}

  And %{I choose "Walleye"}
  And %{I choose "Commercial Fishing"}
  And %{I choose "Caught and kept the fish"}
  And %{I fill in "report[found]" with "11/08/2011"}

  And %{I fill in "report_description" with "amazing description"}
  
  And %{I fill in "Internal ID Tag Number" with "ABC123"}

end
