class Hcpc < ApplicationRecord
  def to_s
    "(#{hcpc}) #{short_description}"
  end
end
