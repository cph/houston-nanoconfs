module Houston::Nanoconfs
  class Presentation < ActiveRecord::Base

    self.table_name = "presentations"

    belongs_to  :presenter, class_name: "User"
  end
end
