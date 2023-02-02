class CreateCalls < ActiveRecord::Migration[7.0]
  def change
    drop_table :calls do |t|
      t.string :call
    end
  end
end
