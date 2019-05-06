class AddDefaultValuesToProfile < ActiveRecord::Migration[5.2]
  def up
    change_column :profiles, :first_name, :string, default: ""
    change_column :profiles, :last_name, :string, default: ""
  end
  
  def down
    change_column :profiles, :first_name, :string, default: nil
    change_column :profiles, :last_name, :string, default: nil
  end
end
