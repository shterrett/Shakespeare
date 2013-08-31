require 'spec_helper'

describe Role do

  describe "scene lists" do

    let(:role) do
      role = Role.new
      role.scene_list = ["Scene 1", "Scene 2", "Scene 3"]
      role
    end
    
    it "should return scene_names as an array" do
      role.scene_list.should == ["Scene 1", "Scene 2", "Scene 3"]
    end

    it "should return a count of scenes" do
      role.num_scenes.should == 3
    end

    it "should add a scene to the list" do
      role.scene_list << "scene test" 
      role.scene_list.should include "scene test"
    end

  end

  describe "default values" do

    it "should initialize max_speech_length to 0" do
      Role.new.max_speech_length.should == 0
    end

    it "should initialize line_count to 0" do
      Role.new.line_count.should == 0
    end

    it "should override the initializers" do
      role = Role.new({ max_speech_length: 10, line_count: 5 })
      role.line_count.should == 5
      role.max_speech_length.should == 10
    end

  end

  describe "parsing speech" do

    let(:speech) do
      xml = Nokogiri::XML(File.open("spec/fixtures/one_speech.xml"))
     Speech.new  xml.xpath("//SPEECH")[0]
    end
    let(:role) { Role.new }

    it "should set the max_speech_length and max_speech_text to a speech with more lines" do
      role.set_max_speech(speech)
      role.max_speech_length.should == 5
      role.max_speech_text.should == """Hence! home, you idle creatures get you home:
Is this a holiday? what! know you not,
Being mechanical, you ought not walk
Upon a labouring day without the sign
Of your profession? Speak, what trade art thou?"""
    end

    it "should not replace max speech if length is less" do
      role.max_speech_length = 100 
      role.max_speech_text = "test"
      role.set_max_speech(speech)
      role.max_speech_length.should == 100
      role.max_speech_text.should == "test"
    end

  end

end
