# frozen_string_literal: true

class Attachment < ApplicationRecord
  validates :file, presence: true
  belongs_to :attachable, polymorphic: true

  mount_uploader :file, FileUploader
end
