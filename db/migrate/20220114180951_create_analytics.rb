class CreateAnalytics < ActiveRecord::Migration[6.1]
  def change
    create_table :analytics do |t|
      t.string :field
      t.string :value

      t.timestamps
    end
  end
end
