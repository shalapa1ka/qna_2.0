# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.string :file
      t.references :attachmentable, index: true
      t.string :attachmentable_type, index: true
      t.timestamps
    end
  end
end
