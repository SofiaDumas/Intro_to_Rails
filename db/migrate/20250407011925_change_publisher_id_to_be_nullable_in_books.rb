class ChangePublisherIdToBeNullableInBooks < ActiveRecord::Migration[8.0]
  def change
    change_column_null :books, :publisher_id, true
  end
end
