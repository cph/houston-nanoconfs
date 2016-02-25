module Houston::Nanoconfs
  class Presentation < ActiveRecord::Base

    self.table_name = "nanoconf_presentations"

    belongs_to :presenter, class_name: "User"
  end
end
