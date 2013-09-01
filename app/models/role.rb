class Role < ActiveRecord::Base

  belongs_to :play

  serialize :scene_list, Array
  after_initialize :set_defaults
  before_save :sync_scene_count

  def self.sort(play_id, key = :line_count, by = :desc)
    key = :line_count unless key
    by = :desc unless by
    Role.where(play_id: play_id).order("#{key} #{by}").limit(10)
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

  def set_percent_scenes(play_scene_count)
    self.percent_scenes = ( ( self.scene_count.to_f / play_scene_count.to_f ) * 100 ).ceil
  end

  private 

  def sync_scene_count
    self.scene_count = self.scene_list.count
  end

  def set_defaults
    self.max_speech_length ||= 0
    self.line_count ||= 0
    self.scene_list ||= []
    self.scene_count ||= 0
    self.percent_scenes ||= 0
  end

end
