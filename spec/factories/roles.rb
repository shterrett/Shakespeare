# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    max_speech_length 1
    max_speech_text "MyText"
    line_count 1
    scene_list "MyString"
    name "MyString"
    unique_name "MyString"
  end
end
