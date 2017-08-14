TextEditor::Engine.routes.draw do
  get 'texteditor/index'
  root to: 'texteditor#index'
end
