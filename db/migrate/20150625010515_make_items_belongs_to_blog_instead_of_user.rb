class MakeItemsBelongsToBlogInsteadOfUser < ActiveRecord::Migration
  def change
    remove_reference :entries, :user, index: true, foreign_key: true
    add_reference :entries, :blog, index: true, foreign_key: true
  end
end
