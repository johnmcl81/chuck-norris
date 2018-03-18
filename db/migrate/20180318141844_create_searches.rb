class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :text
      t.string :category
      t.string :results

      t.timestamps
    end
  end
end
