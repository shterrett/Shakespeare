require 'spec_helper'

describe Speech do

  let(:speech) do
    doc =  Nokogiri::XML(File.open("spec/fixtures/one_speech.xml"))
    Speech.new(doc.xpath("//SPEECH")[0])
  end

  it "should return the speaker in an array" do
    speech.speaker.should == ["FLAVIUS"]
  end

  it "should return the line count" do
    speech.line_count.should == 5
  end

  it "should return the text of the speech" do
    speech.text.should == 
      """Hence! home, you idle creatures get you home:
Is this a holiday? what! know you not,
Being mechanical, you ought not walk
Upon a labouring day without the sign
Of your profession? Speak, what trade art thou?"""
  end

  it "should return the scene" do
    speech.scene.should == "ACT I SCENE I.  Rome. A street." 
  end

end

