

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
	
	love.window.setTitle ( 'Pong' )
	
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

	if gamestate =='play' then
		
		if ball : collide ( player1 ) then
			ball.dx = -ball.dx * 1.03
			ball.x = player1.x + 5
			
			if ball.dy < 0 then
				ball.dy = -math.random( 10 , 150 )
			else
				ball.dy = math.random ( 10 , 150 )
			end
		end
		
		if ball : collide ( player2 ) then 
			ball.dx = -ball.dx * 1.03
			ball.x = player2.x -4
			
			if ball.dy < 0 then
				ball.dy = -math.random ( 10 , 150 )
			else
				ball.dy = math.random ( 10 , 150 )
			end
		end
		
		if ball.y <= 0 then
			ball.y = 0
			ball.dy = -ball.dy 
		end
		
		if ball.y >= VIRTUAL_HEIGHT - 4 then 
			ball.y = VIRTUAL_HEIGHT - 4
			ball.dy = -ball.dy
		end
		
	end

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
		
		displayFPS()

	push : apply ('end')

end

function displayFPS()

	love.graphics.setColor(0, 255/255, 0, 255/255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5 , 5 )
	
end

