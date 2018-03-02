class BreakWikiloop < ActiveRecord::Migration[5.0]
  def change
    WikiPage.all.each do |wiki_page|
      ascendants = wiki_page.self_and_ascendants.map(&:id)
      if ascendants.count > 1 and ascendants[0] == ascendants[-1]
        # break the loop
        wiki_page.sub_page_id = nil
        wiki_page.save

      end
    end
  end
end
