class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :short_url
      t.string :original_url

      t.timestamps
    end
  end
end
