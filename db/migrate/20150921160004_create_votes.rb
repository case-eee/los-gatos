class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :type
      t.references :cat, index: true, foreign_key: true
      t.string :IP_Address

      t.timestamps null: false
    end
  end
end
