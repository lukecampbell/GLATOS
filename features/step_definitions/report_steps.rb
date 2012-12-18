Given /^I fill in a valid report$/ do

  step %{I fill in "Full Name" with "Kyle Wilcox"}
  step %{I fill in "Address" with "55 Village Square Drive"}
  step %{I fill in "City" with "South Kingstown"}
  step %{I fill in "Telephone" with "555-555-5555"}
  step %{I fill in "Email" with "report_submitted@glatos.org"}
  step %{I fill in "Fish Length" with "20"}
  step %{I fill in "Zip Code" with "55555"}
  step %{I select "Michigan" from "State/Province"}

  step %{I choose "Walleye"}
  step %{I choose "Commercial Fishing"}
  step %{I choose "Caught and kept the fish"}
  step %{I fill in "report[found]" with "11/08/2011"}

  step %{I fill in "report_description" with "amazing description"}
  
  step %{I fill in "Internal ID Tag Number" with "ABC123"}

end
