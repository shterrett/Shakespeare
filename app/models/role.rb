class Role < ActiveRecord::Base

  serialize :scene_list, Array
  after_initialize :set_defaults


  def num_scenes
    self.scene_list.count
  end

  def set_max_speech(speech)
    if speech.line_count > self.max_speech_length
      self.max_speech_length = speech.line_count 
      self.max_speech_text = speech.text
    end
  end

  private 

  def set_defaults
    self.max_speech_length ||= 0
    self.line_count ||= 0
    write_attribute(:scene_list, "") 
  end

end
