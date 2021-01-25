
-- adding push and class lua file 

push = require 'push'
Class = require 'class'

-- adding classes ball and paddel made 

require 'Ball'
require 'Paddel'

--######################################################################################################

-- setting window width and height

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- setting virtual width and height

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- adding variable paddel speed

PADDEL_SPEED = 200

--#####################################################################################################
-- love.load begin 

-- setting the screen and declaring object for paddel and ball
--#####################################################################################################
function love.load()

	love.graphics.setDefaultFilter('nearest', 'nearest')
	
	math.randomseed(os.time())
	
	love.window.setTitle ( 'Pong' )
	
	push : setupScreen( VIRTUAL_WIDTH , VIRTUAL_HEIGHT , WINDOW_WIDTH, WINDOW_HEIGHT, {
	fullscreen  = false,
	resizable = true,
	vsync =true
	})
	
	--declaring object of paddel class
	
	player1 = Paddel ( 5 , 30 , 5 , 20 )
	player2 = Paddel ( VIRTUAL_WIDTH -10 , VIRTUAL_HEIGHT - 40 , 5 , 20 )
	
	-- declaring object of ball class 
	
	ball = Ball ( VIRTUAL_WIDTH/2 , VIRTUAL_HEIGHT/2 , 3 , 3 )
	
	-- declaring variable to store score
	player1score = 0
	player2score =0
	
	gamestate = 'serve'
	
	servingplayer = 1
	winningplayer = 0
	
end
--#######################################################################################################
--  love.load end
--#######################################################################################################



--#######################################################################################################
--  love.resize begin
--#######################################################################################################

function love.resize( w , h )

	push : resize ( w, h )

end

--#######################################################################################################
--  love.resize end
--#######################################################################################################




--#######################################################################################################
--  love.update begin

-- gamestate serve 
-- reset the ball

--gamestate play
-- collision of ball with paddel
-- collision of ball with upper and lower screen
-- calling ball update function

--victory message
-- movement of paddel ( key declaration )
-- calling paddel update function
--#######################################################################################################

function love.update(dt)

--************************************
-- gamestate serve

	if gamestate =='serve' then
	
		ball : reset()
		if servingplayer == 1 then
			ball.dx = 100
			gamestate = 'start'
		end
		
		if servingplayer == 2 then
			ball.dx = -100
			gamestate = 'start'
		end
		
	end
	
--***********************************
--gamestate play

	if gamestate =='play' then

-- score increament player2

		if  ball.x < 0  then 
		player2score = player2score + 1
		servingplayer = 2
		gamestate = 'serve'
		end

-- score increament player1
		
		if ball.x > VIRTUAL_WIDTH then
		player1score = player1score + 1
		servingplayer = 1
		gamestate = 'serve'
		end

--    collision of ball with player1 's paddel
		
		if ball : collide ( player1 ) then
			ball.dx = -ball.dx * 1.03
			ball.x = player1.x + 5
			
			if ball.dy < 0 then
				ball.dy = -math.random( 10 , 150 )
			else
				ball.dy = math.random ( 10 , 150 )
			end
		end

--   collision of ball with player2 's paddel 
		
		if ball : collide ( player2 ) then 
			ball.dx = -ball.dx * 1.03
			ball.x = player2.x -4
			
			if ball.dy < 0 then
				ball.dy = -math.random ( 10 , 150 )
			else
				ball.dy = math.random ( 10 , 150 )
			end
		end
		
--    collision of ball with upper screen 

		if ball.y <= 0 then
			ball.y = 0
			ball.dy = -ball.dy 
		end
		
-- 	  collision of ball with lower screen

		if ball.y >= VIRTUAL_HEIGHT - 4 then 
			ball.y = VIRTUAL_HEIGHT - 4
			ball.dy = -ball.dy
		end
		
--      updating state of ball
 
		ball : update ( dt )
		
--		victory determining

		if player1score == 10 then
			winningplayer = 1
			servingplayer = 2
			gamestate = 'done'
		end
		
		if player2score ==10 then 
			winningplayer = 2
			servingplayer = 1
			gamestate = 'done'
		end
		
	end
--**************************************
-- movement of paddel ( key declaration )

 --      player1 
 
	if love.keyboard.isDown ('w') then
		player1.dy = -PADDEL_SPEED
		
	elseif love.keyboard.isDown ('s') then
		player1.dy = PADDEL_SPEED
		
	else
		player1.dy = 0

	end

--        player2

	if love.keyboard.isDown ('up') then
		player2.dy = -PADDEL_SPEED
	
	elseif love.keyboard.isDown ('down') then
		player2.dy = PADDEL_SPEED
		
	else
		player2.dy = 0

	end

--************************************************
-- updating position of paddel ( both player1 and player2 )

	player1 : update ( dt )
	player2 : update ( dt )
		
end

--#######################################################################################################
--  love.update end
--#######################################################################################################



--#######################################################################################################
--  love.keypressed begin

-- escape key to end the game
-- enter to change the gamestate from start to play
--#######################################################################################################

function love.keypressed( key )

	if key == 'escape' then 
		love.event.quit()
		
	elseif key == 'enter' or key == 'return' then
	
		if gamestate =='start' then
			gamestate = 'play'
		else
			gamestate = 'start'
			ball : reset()
			
		if gamestate == 'done' then
			
			winningplayer = 0
			player1score = 0
			player2score = 0
			gamestate = 'serve'
			
		end
		end
		
	end
	
end

--#######################################################################################################
--  love.keypressed end
--#######################################################################################################



--#######################################################################################################
--  love.draw begin

-- print the hello pong and scores
-- calling the render function
--#######################################################################################################

function love.draw()

	push : apply ('start')

		love.graphics.clear(40/255, 45/255, 52/255, 255/255)


		love.graphics.print(tostring(player1score),VIRTUAL_WIDTH/2 - 60 , VIRTUAL_HEIGHT/2 - 60)
		love.graphics.print(tostring(player2score),VIRTUAL_WIDTH/2 + 60 , VIRTUAL_HEIGHT/2 - 60)
		
		if gamestate == 'serve' or gamestate == 'start' then 
			love.graphics.printf ( 'PLAYER ' .. tostring( servingplayer ) .. ' SERVE ' , 0 , 20 , VIRTUAL_WIDTH , 'center' )
		end
		
		if gamestate == 'done' then 
			love.graphics.printf ( 'PLAYER ' .. tostring( winningplayer ) .. ' WON ' , 0 , 5 , VIRTUAL_WIDTH , 'center')
			else
			love.graphics.printf('HELLO PONG!', 0 , 5, VIRTUAL_WIDTH , 'center')
		end

		player1 : render ()
		player2 : render ()
		ball : render ()
		
		displayFPS()

	push : apply ('end')

end

--#######################################################################################################
--  love.draw end
--#######################################################################################################


--#######################################################################################################
--  display fps begin

-- display the fps
--#######################################################################################################

function displayFPS()

	love.graphics.setColor(0, 255/255, 0, 255/255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5 , 5 )
	
end

--#######################################################################################################
--  display fps end
--#######################################################################################################

