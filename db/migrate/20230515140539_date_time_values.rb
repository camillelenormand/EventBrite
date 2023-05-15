class DateTimeValues < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :created_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :events, :updated_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :attendances, :created_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :attendances, :updated_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :users, :created_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :users, :updated_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
