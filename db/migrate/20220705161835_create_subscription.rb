class CreateSubscription < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :question, index: true
      t.boolean :update_question, default: false
      t.boolean :new_answer, default: false
      t.timestamps
    end
  end
end
