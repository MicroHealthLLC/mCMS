StickyNotes::Engine.routes.draw do
  get 'sticky_notes/index'
  get 'sticky_notes/save'
  root to: 'sticky_notes#index'
end
