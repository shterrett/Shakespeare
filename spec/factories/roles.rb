# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    max_speech_length 1
    max_speech_text "MyText"
    line_count 1
    scene_list ["Scene 1", "Scene 2", "Scene 3"] 
    name "Character"
    unique_name "Play Character"

    factory :random_role do
      max_speech_length { Random.rand(0..150) }
      max_speech_text """I'd like to think that I haven't changed those things, sir. Computer, belay that order. 
I think you've let your personal feelings cloud your judgement. My oath is between Captain Kargan and myself. 
Your only concern is with how you obey my orders. Or do you prefer the rank of prisoner to that of lieutenant? 
Travel time to the nearest starbase? Maybe we better talk out here; the observation lounge has turned into a swamp. 
We have a saboteur aboard. Shields up! Rrrrred alert! I suggest you drop it, Mr. Data."""
      line_count { Random.rand(1..10000) }
    end

  end
end
