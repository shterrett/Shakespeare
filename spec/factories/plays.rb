# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :play do
    title "Caesar"
   full_text { File.open("spec/fixtures/one_speech.xml") } 
    factory :plaintext_play do
      full_text_content_type 'text/text'
    end

  end

end
