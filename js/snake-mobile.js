$(function($){
  $(function() {
    $(document).ready(function() {
      $(".StartButton").click(function() {
        $(".SplashScreen").hide();
        $(".FinishScreen").hide();
        $("#canvasArea").show();
        init();
      });
      
      const theme = new Howl({
        src: ['/files/project4.ogg', '/files/project4.mp3', '/files/project4.wav'],
        loop: true,
        volume: .2
      });
      
      const canvas = $("#canvasArea")[0];
      const ctx = canvas.getContext("2d");
      const w = canvas.width;
      const h = canvas.height;
      
      const snake_color = "lightblue";
      const snake_border = "darkblue";
      
      const food_color = 'lightgreen';
      const food_border = "darkgreen";
      
      var snake;
      var dx;
      var dy;
      var changingDirection;
      var foodX;
      var foodY;
      var score;
      
      var themeId;
      
      function init() {
        snake = [
          {x: 200, y: 200},
          {x: 190, y: 200},
          {x: 180, y: 200},
          {x: 170, y: 200},
          {x: 160, y: 200}
        ];
        
        dx = 10;
        dy = 0;
        changingDirection = false;
        
        score = 0;
        
        main();
        genFood();
        
        themeId = theme.play();
        
        dataLayer.push({
          event: 'game',
          type: 'start',
          data: {start_time: performance.now()}
        });
      }
      
      function main() {
        if(hasGameEnded()) {
          $("#canvasArea").hide();
          $(".FinishScreen").show();
          theme.stop();
          
          dataLayer.push({
            event: 'game',
            type: 'over',
            data: {score: score, end_time: performance.now()}
          });
          return;
        }
        changingDirection = false;
        setTimeout(function() {
          ctx.clearRect(0, 0, w, h);
          drawFood();
          moveSnake();
          drawSnake();
          
          main();
        }, 1000 / 4);
      }
      
      function moveSnake() {
        var head = {
          x: snake[0].x + dx,
          y: snake[0].y + dy
        };
        
        snake.unshift(head);
        
        if(head.x === foodX && head.y === foodY) {
          score += 10;
          
          $("#score").text(score);
          
          genFood();
        } else {
          snake.pop();
        }
      }
      
      function drawFood() {
        ctx.fillStyle = food_color;
        ctx.strokeStyle = food_border;
        ctx.fillRect(foodX, foodY, 10, 10);
        ctx.strokeRect(foodX, foodY, 10, 10);
      }
      
      function drawSnakePart(part) {
        ctx.fillStyle = snake_color;
        ctx.strokeStyle = snake_border;
        
        ctx.fillRect(part.x, part.y, 10, 10);
        ctx.strokeRect(part.x, part.y, 10, 10);
      }
      
      function drawSnake() {
        snake.forEach(drawSnakePart);
      }
      
      function hasGameEnded() {
        for(var i = 4; i < snake.length; i++) {
          if(snake[0].x === snake[i].x && snake[0].y === snake[i].y)
            return true;
        }
        
        const hitRightWall = snake[0].x - 10 > w;
        const hitBottomWall = snake[0].y - 10 > h;
        const hitLeftWall = (snake[0].x < 0);
        const hitToptWall = (snake[0].y < 0);
        
        return hitRightWall || hitBottomWall || hitLeftWall || hitToptWall;
      }
      
      function randomFood(min, max) {
        return Math.round((Math.random() * (max-min) + min) / 10) * 10;
      }
      
      function genFood() {
        foodX = randomFood(0, w - 10);
        foodY = randomFood(0, h - 10);
        
        snake.forEach(function(part) {
          if(part.x === foodX && part.y === foodY) genFood();
        });
      }
      
      function changeDirection(e) {
        var key = e.keyCode;
        
        const KEY_RIGHT = "37";
        const KEY_DOWN = "38";
        const KEY_LEFT = "39";
        const KEY_UP = "40";
        
        const goingRight = dx === 10;
        const goingDown = dy === 10;
        const goingLeft = dx === -10;
        const goingUp = dy === -10;
        
        if(changingDirection) return;
        changingDirection = true;
        if(key == KEY_RIGHT && !goingLeft) {
          dx = 10;
          dy = 0;
        }
        
        if(key == KEY_DOWN && !goingUp) {
          dx = 0;
          dy = 10;
        }
        
        if(key == KEY_LEFT && !goingRight) {
          dx = -10;
          dy = 0;
        }
        
        if(key == KEY_UP && !goingDown) {
          dx = 0;
          dy = -10;
        }
      }
      
      $(document).keydown(changeDirection);
      
      $('.control').click(function() {
        var e;
        if($(this).is('#right'))
          e = 37;
        else if($(this).is('#down'))
          e = 38;
        else if($(this).is('#left'))
          e = 39;
        else if($(this).is('#up'))
          e = 40;
          
        changeDirection({keyCode: e});
      });
    });
  });
}(jQuery));