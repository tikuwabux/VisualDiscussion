FactoryBot.define do
  factory :ref_reason do
    ref_conclusion { nil }
    ref_reason_summary { "MyString" }
    ref_reason_detail { "MyText" }
  end
end
