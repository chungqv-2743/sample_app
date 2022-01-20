class CreateRequestTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :request_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string "token", null: false, comment: "authentication token"
      t.timestamps
    end
  end
end
