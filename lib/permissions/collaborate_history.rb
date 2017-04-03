#Collaborate
RedCarpet::AccessControl.map do |map|

  map.project_module :forum do |map|
    map.permission :view_forum, {'thredded/messageboards' => [:index]},  :read => true
  end

  map.project_module :my_checklists do |map|
    map.permission :manage_sticky, {:sticky => [:index, :save]},  :read => true
  end

  map.project_module :my_sticky_note do |map|
    map.permission :manage_sticky_notes, {'sticky_notes/sticky_notes' => [:index, :save]},  :read => true
  end

  map.project_module :my_todo_list do |map|
    map.permission :manage_todo_list, {'todo_list/todos' => [:index, :save]},  :read => true
  end

  map.project_module :chat_room do |map|
    map.permission :make_chat, {:chat_rooms => [:create_or_find, :show]},  :read => true
    map.permission :view_conference, {:chat_rooms => [:conference]},  :read => true
  end

  map.project_module :document_managers do |map|
    map.permission :manage_document_managers, {:document_managers => [:index, :show, :search, :destroy, :create, :update, :download],
                                               :revisions=>[:download, :create]},  :read => true
  end

  map.project_module :wikis do |map|
    map.permission :manage_wikis, {:wikis => [:index, :show, :new, :show, :create, :edit, :update, :history, :compare, :add_attachment, :destroy]},  :read => true
  end
  map.project_module :news do |map|
    map.permission :view_news, {:news => [:index]}, :read => true
    map.permission :show_news, {:news => [:show]}, :read => true
    map.permission :create_news, {:news => [:new, :create]}, :read => true
    map.permission :edit_news, {:news => [:edit, :update]}, :read => true
    map.permission :delete_news, {:news => [:destroy]}, :read => true
    map.permission :manage_news, {:news => [:index, :show, :new, :create, :edit, :update, :destroy]}, :read => true
  end

  map.project_module :rordit do |map|
    map.permission :view_rordit, {"rordit/links" => [:index, :show, :get_search_results, :get_link,
                                                     :get_popular_links, :get_newest_links]},  :read => true
    map.permission :create_link_share, {"rordit/links" => [:new, :create]},  :read => true
    map.permission :create_comment_link_share, {"rordit/comments" => [:new, :create]},  :read => true
    map.permission :give_point_link_share, {"rordit/points" => [:give_point_to_link, :give_point_to_comment]},  :read => true
    map.permission :manage_link_share, { "rordit/comments" => [:new, :create],
                                         "rordit/points" => [:give_point_to_link, :give_point_to_comment],
                                         "rordit/links" => [:index, :show, :get_search_results, :get_link,
                                                            :get_popular_links, :get_newest_links, :new, :create]},  :read => true
  end


end
