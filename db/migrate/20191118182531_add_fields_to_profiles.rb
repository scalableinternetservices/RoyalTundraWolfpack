class AddFieldsToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :age, :integer
    add_column :profiles, :gender, :string
  end
end
