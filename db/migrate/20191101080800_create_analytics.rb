class CreateAnalytics < ActiveRecord::Migration[5.1]
  def change
    create_table :analytics do |t|
      t.integer 'total_request', default: 0
      t.jsonb 'detail', default: {}
      t.integer 'url_id'
      t.timestamps
    end
  end
end
