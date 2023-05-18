class AddSessionId < ActiveRecord::Migration[7.1]
  def change
    add_column :attendances, :stripe_checkout_session_id, :string
  end
end
