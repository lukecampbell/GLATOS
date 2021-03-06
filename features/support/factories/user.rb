FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'user@test.com'
    password 'please'
    role 'general'

    trait :approved do
      approved true
    end

    trait :admin do
      role "admin"
      name 'Admin User'
      email 'admin@test.com'
    end

    trait :investigator do
      role 'investigator'
      name 'Investigator User'
      email 'investigator@glatos.org'
    end

    trait :researcher do
      role "researcher"
      name 'Researcher User'
      email 'researcher@glatos.org'
    end

    factory :admin_user,              :traits => [:approved, :admin]
    factory :approved_user,           :traits => [:approved]

    factory :unapproved_investigator, :traits => [:investigator]
    factory :approved_investigator,   :traits => [:approved, :investigator]

    factory :unapproved_researcher,   :traits => [:researcher]
    factory :approved_researcher,     :traits => [:approved, :researcher]

    after (:create) do |user, proxy|
      user.confirm! unless proxy.confirmed?
    end

  end
end
