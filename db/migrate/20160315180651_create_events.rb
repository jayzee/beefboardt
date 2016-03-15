class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.text :description
      t.datetime :event_time
      t.datetime :signup_deadline
      t.float :cost_per_person
      t.float :flat_cost
      t.integer :minimum_attendees
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
