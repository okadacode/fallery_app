class AddIconHeaderToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :icon, :string
    add_column :users, :header, :string
  end
end
