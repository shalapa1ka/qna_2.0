# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :body
      t.timestamps
      t.references :user, index: true
    end
  end
end
