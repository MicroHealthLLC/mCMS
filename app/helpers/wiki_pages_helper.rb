module WikiPagesHelper
  acts_as_wiki_pages_helper

  def render_subpages(page)
    output = '<ul>'
    WikiPage.where(sub_page_id: page.id).each do |sub_page|
      output << "<li>#{link_to sub_page.title, sub_page}</li>"
      output<< render_subpages(sub_page)
    end
    output<<'</ul>'
    output
  end
end
