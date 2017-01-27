class AddDateToPages < ActiveRecord::Migration
  def change
    add_column :pages, :date, :date
  end
end
