class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :votable, polymorphic: true
      t.belongs_to :user
      t.timestamps
    end
  end
end


