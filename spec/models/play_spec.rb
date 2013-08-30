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
      invalid_play.should_not be_valid
    end

  end

end
