class Play < ActiveRecord::Base

  has_many :roles
  has_attached_file :full_text

  validates_attachment :full_text, :presence => true,
      :content_type => { :content_type => "text/xml" }

  after_create :parse_play

  def role_map
    @role_map ||= {}
  end

  def set_title(xml)
    self.title= xml.xpath("PLAY/TITLE").text
  end

  def extract_speeches(xml)
    xml.xpath("//SPEECH")
  end

  def get_role(speaker)
    self.role_map[speaker] || Role.new({ name: speaker, unique_name: "#{self.title} #{speaker}" })
  end


  private 

  def parse_play
    xml = Nokogiri::XML(File.open(self.full_text.url))
    set_name(xml)
    speeches = extract_speeches(xml)
    speeches.each do |xml_speech|
      speech = Speech.new(xml_speech)
      speakers = speech.speaker
      speakers.each do |speaker|
        role = get_role(speaker) 
        role.line_count += speech.line_count
        role.scene_list << speech.scene
        role.set_max_speech(speech)
        self.role_map[speaker] = role
      end
    end
   self.role_map.each do |key, value|
     value.save
   end
  end

end
