function love.load(arg)
  if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
  
  paddleMargin = 30
  paddleWidth = 20
  paddleHeight = 60
  paddleSpeed = 500
  
  ballSpeed = 300
  
  scoreMarginX = 300
  scoreMarginY = 50
  textScale = 2
  
  height = love.graphics.getHeight( )
  width = love.graphics.getWidth()
  ball = {}
  ball.x = width/2
  ball.y = height/2
  ball.speedx = ballSpeed
  ball.speedy = ballSpeed
  ball.radius = 30
  
  leftpaddle = {}
  leftpaddle.x = paddleMargin
  leftpaddle.y = height/2
  
  rightpaddle = {}
  rightpaddle.x = width - paddleMargin
  rightpaddle.y = height/2;
  
  leftscore = 0
  rightscore = 0
  
  started = false
end

function resetBall()
  ball.x = width/2
  ball.y = height/2
end

function love.keypressed()
  started = true
end

function love.update(dt)
  
  if ( started ) then
    ball.x = ball.x + ball.speedx * dt
    ball.y = ball.y + ball.speedy * dt
  end
  
  if love.keyboard.isDown("w") then
    leftpaddle.y = leftpaddle.y - paddleSpeed * dt
  elseif love.keyboard.isDown("s") then
    leftpaddle.y = leftpaddle.y + paddleSpeed * dt
  end
  
  if love.keyboard.isDown("up") then
    rightpaddle.y = rightpaddle.y - paddleSpeed * dt
  elseif love.keyboard.isDown("down") then
    rightpaddle.y = rightpaddle.y + paddleSpeed * dt
  end
  
  -- ball to the right of the screen
  if ( ball.x > width ) then
    leftscore = leftscore + 1
    resetBall()
    ball.speedx = -ballSpeed
  end
  
  -- ball to the left of the screen
  if ( ball.x < 0 ) then
    rightscore = rightscore + 1
    resetBall()
    ball.speedx = ballSpeed
  end
  
  -- ball too high
  if ( ball.y < ball.radius/2 ) then
    ball.speedy = ballSpeed
  end
  
  -- ball too low
  if ( ball.y > height-ball.radius/2 ) then
    ball.speedy = -ballSpeed
  end
  
  -- ball hits left paddle
  if ( ball.x - ball.radius/2 <= leftpaddle.x + paddleWidth/2 ) then
    if ( math.abs(ball.y-leftpaddle.y) <= paddleHeight/2 ) then
      ball.speedx = ballSpeed
    end
  end
  
  -- ball hits right paddle
  if ( ball.x + ball.radius/2 >= rightpaddle.x - paddleWidth/2 ) then
    if ( math.abs(ball.y-rightpaddle.y) <= paddleHeight/2 ) then
      ball.speedx = -ballSpeed
    end
  end
end


function love.draw()
  love.graphics.print(leftscore, scoreMarginX, scoreMarginY, 0, textScale, textScale)
  love.graphics.print(rightscore, width-scoreMarginX, scoreMarginY, 0, textScale, textScale)
  -- draw ball
  love.graphics.circle("fill", ball.x, ball.y, 20, ball.radius)
  -- draw leftpaddle
  love.graphics.rectangle("line", leftpaddle.x - paddleWidth/2, leftpaddle.y - paddleHeight/2, paddleWidth, paddleHeight)
  -- draw rightpaddle
  love.graphics.rectangle("line", rightpaddle.x - paddleWidth/2, rightpaddle.y - paddleHeight/2, paddleWidth, paddleHeight)
end
