class CreateUserTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tokens do |t|
      t.string :token, unique: true
      t.datetime :token_expire, null: false
      t.boolean :remember_me, default: false, null: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
