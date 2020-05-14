# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url, limit: 2048, null: false, index: { using: :hash }
      t.string :digest, null: false, limit: 30, index: { unique: true }

      t.timestamps
    end
  end
end
