class AddColumnGenerateLinkPasswordToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :generate_link_password, :string
  end
end
