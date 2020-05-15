# frozen_string_literal: true

class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.references :link, null: false, foreign_key: true
      t.inet :ip, null: false
      t.jsonb :request_info

      t.timestamps
    end
  end
end
