push = require 'push'
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

	player1Y = 30
	player2Y = VIRTUAL_HEIGHT - 40
	
	ballX = VIRTUAL_WIDTH/2
	ballY = VIRTUAL_HEIGHT/2

	player1score = 0
	player2score =0
	
	

end

function love.update(dt)

	if love.keyboard.isDown ('w') then
		player1Y = math.max ( player1Y - PADDEL_SPEED*dt , 0 )
		
	elseif love.keyboard.isDown ('s') then
		player1Y = math.min ( player1Y + PADDEL_SPEED*dt , VIRTUAL_HEIGHT - 20 )

	end

	if love.keyboard.isDown ('up') then
		player2Y = math.max ( player2Y - PADDEL_SPEED*dt , 0 )
	
	elseif love.keyboard.isDown ('down') then
		player2Y = math.min( player2Y + PADDEL_SPEED*dt , VIRTUAL_HEIGHT - 20 )

	end
end


function love.keypressed( key )

	if key == 'escape' then 
		love.event.quit()
	end
	
end

function love.draw()

	push : apply ('start')

		love.graphics.clear(40/255, 45/255, 52/255, 255/255)


		love.graphics.printf('Hello Pong!', 0 , 5, VIRTUAL_WIDTH , 'center')
		love.graphics.print(tostring(player1score),VIRTUAL_WIDTH/2 - 60 , VIRTUAL_HEIGHT/2 - 60)
		love.graphics.print(tostring(player2score),VIRTUAL_WIDTH/2 + 60 , VIRTUAL_HEIGHT/2 - 60)


		love.graphics.rectangle('fill', 5 , player1Y , 5 , 20)
		love.graphics.rectangle('fill', VIRTUAL_WIDTH -10 , player2Y , 5 , 20)
		love.graphics.rectangle('fill', ballX , ballY , 3 , 3)

	push : apply ('end')

end
