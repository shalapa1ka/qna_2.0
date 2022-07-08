# frozen_string_literal: true

class CreateSocialAuths < ActiveRecord::Migration[6.1]
  def change
    create_table :social_auths do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
