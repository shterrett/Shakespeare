# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :play do
    title "Caesar"
    line_count 100000
    scene_count 100
    full_text { File.open("spec/fixtures/one_speech.xml") } 

    factory :plaintext_play do
      full_text_content_type 'text/text'
    end

    factory :live_play_one do
      full_text {fixture_file_upload("spec/fixtures/one_speech.xml", 'application/xml') }
    end

    factory :play_no_callback do
      after(:build) { |play| play.class.skip_callback(:post_process, :after, :parse_play) }
    end

  end

end
