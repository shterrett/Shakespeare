class Role < ActiveRecord::Base

  belongs_to :play

  serialize :scene_list, Array
  after_initialize :set_defaults
  before_save :sync_scene_count
  before_save :set_percent_scenes

  def self.sort(key = :line_count, by = :desc)
    key = :line_count unless key
    by = :desc unless by
    Role.order("#{key} #{by}").limit(10)
  end

  def set_max_speech(speech)
    if speech.line_count > self.max_speech_length
      self.max_speech_length = speech.line_count 
      self.max_speech_text = speech.text
    end
  end

  def add_scene(scene)
    unless self.scene_list.include? scene
      self.scene_list << scene 
      self.scene_count += 1
    end
  end

  def assign_attributes_from_speech(speech)
    self.line_count += speech.line_count
    self.add_scene(speech.scene)
    self.set_max_speech(speech)
  end

  def percent_scenes
    read_attribute(:percent_scenes) ? read_attribute(:percent_scenes) * 100 : 0
  end

  private 

  def sync_scene_count
    self.scene_count = self.scene_list.count
  end

  def set_percent_scenes
    if self.play
      write_attribute(:percent_scenes, (self.scene_count.to_f / self.play.scene_count.to_f)) 
    end
  end

  def set_defaults
    self.max_speech_length ||= 0
    self.line_count ||= 0
    self.scene_list ||= []
    self.scene_count ||= 0
    self.percent_scenes ||= 0
  end

end
