class Role < ActiveRecord::Base

  belongs_to :play

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

  def add_scene(scene)
    self.scene_list << scene unless self.scene_list.include? scene
  end

  def assign_attributes_from_speech(speech)
    self.line_count += speech.line_count
    self.add_scene(speech.scene)
    self.set_max_speech(speech)
  end

  private 

  def set_defaults
    self.max_speech_length ||= 0
    self.line_count ||= 0
    self.scene_list ||= []
  end

end
