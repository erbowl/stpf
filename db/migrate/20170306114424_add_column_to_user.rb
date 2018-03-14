class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :twitter, :string
    add_column :users, :instagram, :string
    add_column :users, :studyplus, :string
    add_column :users, :department, :text
    add_column :users, :university, :text
    add_column :users, :comment, :text
    add_column :users, :age, :text
    add_column :users, :gender, :string
    add_column :users, :like_subject, :text
    add_column :users, :dislike_subject, :text
    add_column :users, :activity, :text
  end
end
