class Item < ActiveRecord::Base
  belongs_to :list
  default_scope { order('updated_at DESC') }

  def days_left
    (DateTime.now.to_date - created_at.to_date).to_i
  end

end
