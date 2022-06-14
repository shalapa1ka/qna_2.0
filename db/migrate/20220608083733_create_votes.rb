# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :votesable, polymorphic: true
      t.string :vote
      t.integer :votesable_parent_id, index: true
      t.timestamps
    end
  end
end
