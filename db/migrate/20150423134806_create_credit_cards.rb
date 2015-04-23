# migration
class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |tbl|
      tbl.string :number
      tbl.string :owner
      tbl.string :credit_network
      tbl.date :expiration_date
    end
  end
end
