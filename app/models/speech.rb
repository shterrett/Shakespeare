class Speech

  attr_reader :scene, :line_count, :text, :speaker

  def initialize(xml_speech)
    @speaker = self.get_speaker(xml_speech)
    @line_count = self.get_line_count(xml_speech)
    @text = self.get_text(xml_speech)
    @scene = self.get_scene(xml_speech)
  end

  def get_speaker(speech)
    # some passages have multiple speakers. Need to handle
    speech.xpath("SPEAKER").map { |speech| speech.text }
  end

  def get_line_count(speech)
    speech.xpath("LINE").count
  end

  def get_text(speech)
    lines = speech.xpath("LINE").map { |line| line.text }
    lines.join("\n")
  end

  def get_scene(speech)
    act = speech.parent.parent.xpath("TITLE").text
    scene = speech.parent.xpath("TITLE").text
    "#{act} #{scene}"
  end

end

