class Play < ActiveRecord::Base

  has_many :roles
  has_attached_file :full_text

  validates_attachment :full_text, :presence => true #,
      # :content_type => { content_type: [ "application/xml", "text/xml" ] }

  after_create :parse_play

  def role_map
    @role_map ||= {}
  end

  def set_title(xml)
    self.title= xml.xpath("PLAY/TITLE").text
  end

  def extract_speeches(xml)
    xml.xpath("//SPEECH").map { |speech| Speech.new(speech) }
  end

  def get_role(speaker)
    self.role_map[speaker] || self.roles.new({ name: speaker, unique_name: "#{self.title} #{speaker}" })
  end

  def set_line_count(xml)
    self.line_count = xml.xpath("//LINE").count
  end

  def set_scene_count(xml)
    self.scene_count = xml.xpath("//SCENE").count
  end

  def set_play_attributes(xml)
    self.set_line_count(xml)
    self.set_scene_count(xml)
    self.set_title(xml)
  end

  private 

  def parse_play
    file = File.open(self.full_text.url(nil, false))
    xml = Nokogiri::XML(file)
    self.set_play_attributes(xml)
    speeches = extract_speeches(xml)
    speeches.each do |speech|
      speakers = speech.speaker
      speakers.each do |speaker|
        role = get_role(speaker) 
        role.assign_attributes_from_speech(speech)
        self.role_map[speaker] = role
      end
    end
   self.role_map.each do |key, value|
     value.save
   end
  end

end
