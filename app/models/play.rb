class Play < ActiveRecord::Base

  has_many :roles
  has_attached_file :full_text

  validates_attachment :full_text, :presence => true,
      :content_type => { :content_type => "text/xml" }

  def role_map
    @role_map ||= {}
  end

end
