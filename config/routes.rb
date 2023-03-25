Rails.application.routes.draw do
  root 'encode#get_sample_data'
  post '/', to: 'encode#get_data'
end
