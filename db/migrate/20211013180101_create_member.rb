class CreateMember < ActiveRecord::Migration[5.2]
  def up
    create_table :members do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :birthday
      t.integer :games_played, default: 0
      t.integer :rank
      t.boolean :active, default: true
      t.timestamps
    end
  end
end