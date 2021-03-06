class Picture < Asset
  has_attached_file :data,
                    :url  => "/system/photos/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/system/photos/:id/:style_:basename.:extension",
              :styles => { :content => '575>', :thumb => '200x133#' }

validates_attachment_size :data, :less_than => 2.megabytes

def url_content
url(:content)
end

def url_thumb
url(:thumb)
end

def to_json(options = {})
options[:methods] ||= []
options[:methods] << :url_content
options[:methods] << :url_thumb
super options
end
end
