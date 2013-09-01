require 'spec_helper'

describe Role do

  describe "scene lists" do

    let(:role) do
      role = Role.new
      ["Scene 1", "Scene 2", "Scene 3"].each do |scene|
        role.add_scene scene
      end
      role
    end
    
    it "should return scene_names as an array" do
      role.scene_list.should == ["Scene 1", "Scene 2", "Scene 3"]
    end

    it "should return a count of scenes" do
      role.scene_count.should == 3
    end

    it "should add a scene to the list" do
      role.add_scene("scene test")
      role.save
      role.reload
      role.scene_list.should include "scene test"
    end

    it "should not add a scene to the list if it is not unique" do
      role.scene_list = []
      role.add_scene("scene test")
      role.add_scene("scene test")
      role.scene_list.count.should == 1
    end

    it "should set scene_count to scene_list.count on save in case they are out of sync" do
      role.scene_list << "Scene 4"
      role.scene_count.should == role.scene_list.count - 1
      role.save
      role.reload
      role.scene_count.should == role.scene_list.count
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

    it "should initialize scene count to 0" do
      Role.new.scene_count.should == 0
    end

    it "should initialize percent_scenes to 0" do
      Role.new.percent_scenes.should == 0
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

    it "should change line_count, scene_list, and max_speech with speech" do
      role.assign_attributes_from_speech(speech)
      role.line_count.should == speech.line_count
      role.max_speech_length.should == speech.line_count
      role.max_speech_text.should == speech.text
      role.scene_list.should == [speech.scene]
    end

  end

  describe "calculating percent scenes" do

    let(:play) { FactoryGirl.create(:play_no_callback) }
    let(:role) do
      role = FactoryGirl.create(:random_role)
      play.roles << role 
      role.save
      role.reload
    end

    it "should set percent_scenes to self.scene_count / play.scene_count (x100 for percent) before save" do
      role.percent_scenes.should == role.scene_count.to_f / play.scene_count.to_f * 100
    end

  end

  describe "sorting" do
    
    before(:all) do
      Role.all.each { |role| role.destroy }
      play = FactoryGirl.create(:play)
      15.times do
        play.roles << FactoryGirl.create(:random_role)
      end
    end

    it "should return 10 results" do
      Role.sort.count.should == 10
    end

    it "should default to descending line-count" do
      roles = Role.sort
      roles[0].line_count.should > roles[1].line_count
    end

    it "should sort by passed parameter, defaulting to descending" do
      [:line_count, :max_speech_length, :scene_count, :percent_scenes].each do |atrb|
        roles = Role.sort(atrb)
        roles[0].send(atrb).should > roles[1].send(atrb)
      end
    end

    it "should sort ascending" do
      roles = Role.sort(:line_count, :asc)
      roles[0].line_count.should < roles[1].line_count
    end

    it "should sort descending" do
      roles = Role.sort(:line_count, :desc)
      roles[0].line_count.should > roles[1].line_count
    end

    it "should default to descending if by parameter is nil" do
      roles = Role.sort(:line_count, nil)
      roles[0].line_count.should > roles[1].line_count
    end

    it "should default to line_count if key parameter is nil" do
      roles = Role.sort(nil, :desc)
      roles[0].line_count.should > roles[1].line_count
    end

  end

end
