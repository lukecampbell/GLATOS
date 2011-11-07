FactoryGirl.define do
  factory :tag_deployment do
    common_name Fish::TYPES[0]
    release_location "In a River"
    release_date Time.now - 1.year
  end
end
