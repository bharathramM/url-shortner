# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.text 'source'
      t.text 'shorten'
      t.timestamps
    end

    add_index :urls, :shorten
  end
end
