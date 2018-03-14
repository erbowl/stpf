class CreateCheers < ActiveRecord::Migration[5.0]
  def change
    create_table :cheers do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.boolean :is_valid
      t.timestamps
    end
  end
end
