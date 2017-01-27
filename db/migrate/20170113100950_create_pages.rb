class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
