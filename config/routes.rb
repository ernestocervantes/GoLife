Rails.application.routes.draw do
  
  	root 'game#index'

   	resources :game, :path => "/" do
    collection do
      		post 'start' => 'game#start' 
      		post 'stop' => 'game#stop' 
    	end
	end
  
end
