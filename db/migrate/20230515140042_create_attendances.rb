class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.timestamps
    end
    add_reference :attendances, :user, foreign_key: true
    add_reference :attendances, :event, foreign_key: true
  end
end
