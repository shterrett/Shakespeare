require 'spec_helper'

describe Play do

  let(:play) { Play.new }
    
  describe "role map" do

    it "should respond to role_map" do
      play.should respond_to :role_map
    end

    it "it should return an empty map on initialize" do
      play.role_map.should == {}
    end

    it "should accept a map key,value assignment" do
      play.role_map[:test_key] = "test_value"
      play.role_map[:test_key].should == "test_value"
    end

  end

  describe "associations" do

    it "should have_many roles" do
      play.should respond_to :roles
    end

  end

  describe "attachments" do

    let(:invalid_play) { FactoryGirl.build(:plaintext_play) }

    it "should have attachment named full_text" do
      play.should respond_to :full_text
    end

    it "should not be valid without full_text" do
      play.should_not be_valid
    end

    it "should not be valid if attachment is not xml" do
      pending
      invalid_play.should_not be_valid
    end

  end

  describe "play parsing" do

    let(:play) { FactoryGirl.build(:play) }
    let(:xml) do
      xml = Nokogiri::XML(File.open("spec/fixtures/one_speech.xml"))
    end

    it "should set it's title from the xml document" do
      play.set_title(xml)
      play.title.should == "The Tragedy of Julius Caesar"
    end

    it "should return an array of speeches" do
      speeches = play.extract_speeches(xml)
      speeches.should be_an_instance_of Array
      speeches[0].should be_an_instance_of Speech
      speeches[0].speaker.should == ["FLAVIUS"]
    end

    describe "creating roles" do

      let(:speaker) { speaker = xml.xpath("//SPEECH")[0].xpath("SPEAKER").text }
      let(:role) do
        play.set_title(xml)
        play.get_role(speaker)
      end

      it "should return a role object from a speech" do
        role.should be_an_instance_of Role
        role.name.should == speaker
        role.unique_name.should == "The Tragedy of Julius Caesar FLAVIUS"
      end

      it "should return a role that belongs_to itself" do
        play.roles.should include role
      end

    end

  end

  describe "parsing play on create" do

    let(:play) { FactoryGirl.create(:play) }
    before(:all) do
      play.parse_play 
    end

    it "should set the number of lines" do
      play.line_count.should == 5
    end

    it "should set the number of scenes" do
      play.scene_count.should == 1
    end

    it "should set the play title" do
      play.title.should == "The Tragedy of Julius Caesar"
    end

    it "should add the role model to it's has_many" do
      play.roles.count.should == 1
    end

  end

end
