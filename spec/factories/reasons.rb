FactoryBot.define do
  factory :reason do
    conclusion_id { 1 }
    reason_summary { "MyString" }
    reason_detail { "MyText" }
  end
end
