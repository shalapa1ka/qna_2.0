# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.string :file
      t.references :attachable, index: true
      t.string :attachable_type, index: true
      t.timestamps
    end
  end
end
