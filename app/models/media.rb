class Media < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :producto

end
