require 'spec_helper'

describe Role do

  describe "scene lists" do

    let(:role) do
      role = Role.new
      role.scene_list = ["Scene 1", "Scene 2", "Scene 3"]
      role
    end
    
    it "should serialize scene names to a string" do
      role.read_attribute(:scene_list).should == "Scene 1,Scene 2,Scene 3"
    end

    it "should return scene_names as an array" do
      role.scene_list.should == ["Scene 1", "Scene 2", "Scene 3"]
    end

    it "should return a count of scenes" do
      role.num_scenes.should == 3
    end

  end

end
