FactoryBot.define do
  factory :evidence do
    reason_id { 1 }
    evidence_summary { "MyString" }
    evidence_detail { "MyText" }
  end
end
