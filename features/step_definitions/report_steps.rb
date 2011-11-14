Given /^I fill in a valid report$/ do
  Given %{I fill in "Internal ID Tag Number" with "ABC123"}
  And %{I fill in "report_description" with "amazing description"}
  And %{I fill in "Full Name" with "Kyle Wilcox"}
  #And %{I fill in "City" with "South Kingstown"}
  #And %{I fill in "Telephone" with "555-555-5555"}
  And %{I fill in "Email" with "report_submitted@glatos.org"}
  #And %{I fill in "Fish Length" with "20"}
  #And %{I fill in "Fish Weight" with "15"}
  #And %{I select "Michigan" from "State/Province"}
  And %{I fill in "When did you find the tag?" with "11/08/2011"}
  And %{I select "Commercial Fishing" from "How did you find the tag?"}
  And %{I select "Walleye" from "What type of fish?"}
end
