class RemoveTotalAmountFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :total_amount, :integer
  end
end
