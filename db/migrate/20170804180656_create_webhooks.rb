class CreateWebhooks < ActiveRecord::Migration[5.1]
  def change
    create_table :webhooks do |t|
      t.string :project_name
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
