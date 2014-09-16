class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :mobile_no

      t.timestamps
    end
  end
end
