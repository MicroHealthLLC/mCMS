Mhspreadsheet::Engine.routes.draw do
  get 'mh_spreadsheets/index'
  get 'mh_spreadsheets/save'
  root to: 'mh_spreadsheets#index'

end
