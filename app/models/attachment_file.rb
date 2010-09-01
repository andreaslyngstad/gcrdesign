
class AttachmentFile < Asset
  has_attached_file :data,
                    :url => "/assets/attachments/:id/:filename",
                    :path => ":rails_root/public/assets/attachments/:id/:filename"

validates_attachment_size :data, :less_than => 10.megabytes
end