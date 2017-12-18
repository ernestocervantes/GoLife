class GameController < ApplicationController
  	
  before_action :init, only: [:index, :start, :stop, :cols, :rows]

  	def index
  		@@game = Game.new(@cols, @rows)
  	end

  	def start
  		cells = []
  		if params[:load] == 'true'
  			params[:cells].to_hash.values.each do |col, row|
  				cells.push([col.to_i, row.to_i])
  			end
  			@@game.load cells
  		end
  		@grid = @@game.execute
  	end

  	def stop
  		@@game = Game.new(@cols, @rows)
  	end

    private

  	def init
  		@rows = 6
  		@cols = 6
  	end

end