class ReorderEnumeration < ActiveRecord::Migration[5.0]
  def change
    Enumeration.subclasses.each do |enum|
      enum.all.each do |e|
        e.set_default_position
        e.save
      end
    end
  end
end
