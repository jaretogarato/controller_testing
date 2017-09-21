FactoryGirl.define do
  factory :bank_account do
    amount (1..5000).to_a.sample

    institution "Chase"
    description "My Personal Checking Account"

    # we have a FactoryGirl factory for user, so we can just run:
    user
  end
end
