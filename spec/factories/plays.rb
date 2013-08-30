# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :play do
    title "Caesar"
    full_text_file_name  "j_caesar.xml"
    full_text_file_size  1024
    full_text_content_type  'text/xml'
    full_text_updated_at { DateTime.now }
    
    factory :plaintext_play do
      full_text_content_type 'text/text'
    end

  end

end
