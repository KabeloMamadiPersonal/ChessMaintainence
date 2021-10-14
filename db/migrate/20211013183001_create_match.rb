class CreateMatch < ActiveRecord::Migration[5.2]
  def up
    create_table :matches do |t|
      t.references :first_member, index: true, foreign_key: { to_table: :members }
      t.references :second_member, index: true, foreign_key: { to_table: :members }
      t.integer :winning_member_id
      t.timestamps
    end
  end
end