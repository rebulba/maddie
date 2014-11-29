class Photo < ActiveRecord::Base
  belongs_to :project
  
  before_validation :make_url_image
  has_attached_file :avatar,
                    :styles => {
                                :medium => "300x300>", 
                                :thumb => "100x100>", 
                                :auto_bg => "auto_bg" 
                                } 
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
  
  def make_url_image
    if self.avatar.class == String
      self.avatar = open(self.avatar, allow_redirections: :safe)
    end
  end
  
  def suggested_photo_based_on_size
    self.avatar.size < 30000 ? self.avatar.url(:auto_bg) : self.avatar.url(:medium)
  end
end
