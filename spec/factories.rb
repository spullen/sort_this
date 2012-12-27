FactoryGirl.define do

  factory :product do
    sequence(:name) { |n| "ProductName#{n}" }
  end
  
  factory :vendor do
    sequence(:name) { |n| "VendorName#{n}" }
  end
  
  factory :quote do
    product
    vendor
    price 10.99
    quantity 10
  end

end