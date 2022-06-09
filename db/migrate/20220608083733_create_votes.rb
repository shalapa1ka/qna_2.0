class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :votesable, polymorphic: true
      t.string :vote
      t.timestamps
    end
  end
end
