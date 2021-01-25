

push = require 'push'
Class = require 'class'

require 'Ball'
require 'Paddel'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDEL_SPEED = 200


function love.load()

	love.graphics.setDefaultFilter('nearest', 'nearest')
	
	math.randomseed(os.time())
	
	push : setupScreen( VIRTUAL_WIDTH , VIRTUAL_HEIGHT , WINDOW_WIDTH, WINDOW_HEIGHT, {
	fullscreen  = false,
	resizable = false,
	vsync =true
	})
	
	player1 = Paddel ( 5 , 30 , 5 , 20 )
	player2 = Paddel ( VIRTUAL_WIDTH -10 , VIRTUAL_HEIGHT - 40 , 5 , 20 )
	
	ball = Ball ( VIRTUAL_WIDTH/2 , VIRTUAL_HEIGHT/2 , 3 , 3 )
	
	player1score = 0
	player2score =0
	
	gamestate = 'start'
	
end


function love.update(dt)

	if love.keyboard.isDown ('w') then
		player1.dy = -PADDEL_SPEED
		
	elseif love.keyboard.isDown ('s') then
		player1.dy = PADDEL_SPEED
		
	else
		player1.dy = 0

	end

	if love.keyboard.isDown ('up') then
		player2.dy = -PADDEL_SPEED
	
	elseif love.keyboard.isDown ('down') then
		player2.dy = PADDEL_SPEED
		
	else
		player2.dy = 0

	end
	
	if gamestate == 'play' then
		
		ball : update ( dt )
		
	end	
	
	player1 : update ( dt )
	player2 : update ( dt )
		
end


function love.keypressed( key )

	if key == 'escape' then 
		love.event.quit()
		
	elseif key == 'enter' or key == 'return' then
	
		if gamestate =='start' then
			gamestate = 'play'
		else
			gamestate = 'start'
			
			ball : reset()
			
		end
		
	end
	
end


function love.draw()

	push : apply ('start')

		love.graphics.clear(40/255, 45/255, 52/255, 255/255)


		love.graphics.printf('Hello Pong!', 0 , 5, VIRTUAL_WIDTH , 'center')
		love.graphics.print(tostring(player1score),VIRTUAL_WIDTH/2 - 60 , VIRTUAL_HEIGHT/2 - 60)
		love.graphics.print(tostring(player2score),VIRTUAL_WIDTH/2 + 60 , VIRTUAL_HEIGHT/2 - 60)


		player1 : render ()
		player2 : render ()
		ball : render ()

	push : apply ('end')

end

