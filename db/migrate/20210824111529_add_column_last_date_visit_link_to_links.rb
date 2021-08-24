class AddColumnLastDateVisitLinkToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :last_date_visit_link, :datetime
  end
end
