class Dataset
  include Mongoid::Document

  mount_uploader :file, FileUploader

  field :file
  field :user_id

  validates_presence_of :file

  belongs_to :user

end
