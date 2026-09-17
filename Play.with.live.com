<!DOCTYPE html>
<html lang="fa" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>دنیای من | سایت شخصی و بازی</title>
    <link href="https://fonts.googleapis.com/css2?family=Vazirmatn:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        /* تنظیمات کلی */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Vazirmatn', sans-serif;
            background-color: #0a0a0f;
            color: #ffffff;
            overflow-x: hidden;
            background-image: radial-gradient(circle at 15% 50%, rgba(0, 229, 255, 0.15), transparent 25%),
                              radial-gradient(circle at 85% 30%, rgba(184, 0, 255, 0.15), transparent 25%);
        }

        /* نوار بالا */
        nav {
            display: flex; justify-content: space-between; align-items: center;
            padding: 20px 5%; background: rgba(10, 10, 15, 0.8); backdrop-filter: blur(10px);
            position: fixed; width: 100%; top: 0; z-index: 1000;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }
        .logo {
            font-size: 24px; font-weight: 700;
            background: linear-gradient(90deg, #00e5ff, #b800ff);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: #ccc; text-decoration: none; font-size: 14px; transition: 0.3s; }
        .nav-links a:hover { color: #00e5ff; text-shadow: 0 0 10px #00e5ff; }

        /* بخش اصلی (Hero) */
        header {
            height: 100vh; display: flex; flex-direction: column; justify-content: center; align-items: center;
            text-align: center; padding: 0 20px; position: relative;
        }
        header h1 { font-size: 42px; margin-bottom: 20px; min-height: 60px; }
        header h1 span { color: #00e5ff; text-shadow: 0 0 20px rgba(0, 229, 255, 0.6); }
        header p { font-size: 18px; color: #a0a0b0; max-width: 600px; margin-bottom: 40px; line-height: 1.6; }
        .btn-main {
            padding: 15px 40px; font-size: 16px; font-family: inherit; color: #fff;
            background: linear-gradient(45deg, #00e5ff, #b800ff); border: none; border-radius: 50px;
            cursor: pointer; transition: 0.3s; box-shadow: 0 0 20px rgba(0, 229, 255, 0.4);
        }
        .btn-main:hover { transform: scale(1.05); box-shadow: 0 0 40px rgba(184, 0, 255, 0.6); }

        /* بخش کارت‌ها */
        .features { padding: 100px 5%; display: flex; flex-wrap: wrap; justify-content: center; gap: 30px; }
        .card {
            background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 20px; padding: 30px; width: 320px; text-align: center;
            backdrop-filter: blur(10px); transition: 0.4s; display: flex; flex-direction: column; align-items: center;
        }
        .card:hover { transform: translateY(-10px); border-color: #00e5ff; box-shadow: 0 10px 30px rgba(0, 229, 255, 0.1); }
        .card-icon { font-size: 40px; margin-bottom: 20px; }
        .card h3 { font-size: 20px; margin-bottom: 15px; color: #00e5ff; }
        .card p { font-size: 14px; color: #a0a0b0; line-height: 1.6; margin-bottom: 20px; }

        /* بخش ایده‌های برنامه‌نویسی (قاب گوگولی) */
        .cute-grid {
            display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; width: 100%; margin-top: 15px;
        }
        .cute-item {
            background: rgba(255, 255, 255, 0.05); border-radius: 15px; padding: 10px;
            font-size: 12px; color: #eee; display: flex; flex-direction: column; align-items: center; gap: 5px;
            border: 1px dashed rgba(0, 229, 255, 0.3); transition: 0.3s;
        }
        .cute-item:hover { background: rgba(0, 229, 255, 0.1); transform: scale(1.05); }
        .cute-item span { font-size: 24px; }

        /* استایل بازی */
        .game-container {
            width: 100%; display: flex; flex-direction: column; align-items: center; margin-top: 10px;
        }
        #gameCanvas {
            background: #1a1a2e; border-radius: 15px; border: 2px solid #00e5ff;
            width: 100%; max-width: 280px; height: 150px; cursor: pointer;
            box-shadow: 0 0 15px rgba(0, 229, 255, 0.2);
        }
        .game-score { margin-top: 10px; font-weight: bold; color: #b800ff; }

        footer { text-align: center; padding: 30px; border-top: 1px solid rgba(255, 255, 255, 0.05); color: #666; font-size: 14px; }
        
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        header, .features { animation: fadeIn 1.5s ease-out forwards; }
    </style>
</head>
<body>

    <nav>
        <div class="logo">دنیای من</div>
        <div class="nav-links">
            <a href="#home">خانه</a>
            <a href="#features">ویژگی‌ها</a>
            <a href="#contact">تماس</a>
        </div>
    </nav>

    <header id="home">
        <h1>سلام، من <span id="typing-text"></span></h1>
        <p>به سایت شخصی من خوش آمدید! اینجا جایی است که من ایده‌های خفن و پروژه‌های برنامه‌نویسی‌ام را با دنیا به اشتراک می‌گذارم.</p>
        <button class="btn-main" onclick="showAlert()">شروع کنید</button>
    </header>

    <section class="features" id="features">
        <!-- کارت برنامه نویسی -->
        <div class="card">
            <div class="card-icon">🚀</div>
            <h3>برنامه‌نویسی</h3>
            <p>من عاشق کدنویسی هستم و همیشه در حال یادگیری تکنولوژی‌های جدید مثل پایتون و طراحی وب هستم.</p>
        </div>

        <!-- کارت بازی سازی (شامل مینی گیم) -->
        <div class="card">
            <div class="card-icon">🎮</div>
            <h3>بازی‌سازی</h3>
            <p>پروانه بامزه رو با لمس صفحه بپرون تا از شمع‌ها نخوره!</p>
            <div class="game-container">
                <canvas id="gameCanvas" width="280" height="150"></canvas>
                <div class="game-score">امتیاز: <span id="score">0</span></div>
            </div>
        </div>

        <!-- کارت طراحی خلاقانه (شامل ایده‌ها) -->
        <div class="card">
            <div class="card-icon">🎨</div>
            <h3>طراحی خلاقانه</h3>
            <p>ایده‌های خفن برای ساختن:</p>
            <div class="cute-grid">
                <div class="cute-item"><span>🤖</span> هوش مصنوعی</div>
                <div class="cute-item"><span>📱</span> اپلیکیشن موبایل</div>
                <div class="cute-item"><span>🐍</span> بازی با پایتون</div>
                <div class="cute-item"><span>🛡️</span> هک اخلاقی</div>
            </div>
        </div>
    </section>

    <footer id="contact">
        <p>ساخته شده با ❤️ و کدهای خفن | © ۲۰۲۶</p>
    </footer>

    <script>
        // --- افکت تایپ ---
        const textArray = ["یک برنامه‌نویس هستم", "یک طراح وب هستم", "یک بازیساز هستم!"];
        let textIndex = 0, charIndex = 0;
        const typingElement = document.getElementById("typing-text");
        function type() {
            if (charIndex < textArray[textIndex].length) {
                typingElement.textContent += textArray[textIndex].charAt(charIndex);
                charIndex++; setTimeout(type, 100);
            } else { setTimeout(erase, 2000); }
        }
        function erase() {
            if (charIndex > 0) {
                typingElement.textContent = textArray[textIndex].substring(0, charIndex - 1);
                charIndex--; setTimeout(erase, 50);
            } else { textIndex = (textIndex + 1) % textArray.length; setTimeout(type, 500); }
        }
        document.addEventListener("DOMContentLoaded", () => { setTimeout(type, 1000); });
        function showAlert() { alert("به سایت من خوش آمدی! 🚀 امیدوارم لذت ببری."); }

        // --- منطق بازی پروانه و شمع ---
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');
        const scoreElement = document.getElementById('score');
        
        let score = 0;
        let isGameOver = false;
        let gameSpeed = 2.5;
        let frameCount = 0;

        // پروانه (با ایموجی)
        let butterfly = { x: 30, y: 100, width: 30, height: 30, vy: 0, gravity: 0.6, jump: -9, rotation: 0 };
        // شمع‌ها (موانع)
        let candles = [];

        function drawButterfly() {
            ctx.save();
            ctx.translate(butterfly.x + 15, butterfly.y + 15);
            // چرخش ملایم پروانه
            butterfly.rotation += 0.1;
            ctx.rotate(Math.sin(butterfly.rotation) * 0.1); 
            ctx.font = "24px Arial";
            ctx.fillText("🦋", -12, 8);
            ctx.restore();
        }

        function drawCandles() {
            ctx.font = "24px Arial";
            candles.forEach(candle => {
                // رسم شمع (ایموجی)
                ctx.fillText("🕯️", candle.x, candle.y);
            });
        }

        function updateGame() {
            if (isGameOver) return;

            // جاذبه پروانه
            butterfly.vy += butterfly.gravity;
            butterfly.y += butterfly.vy;

            // برخورد با زمین
            if (butterfly.y + 30 > canvas.height) {
                butterfly.y = canvas.height - 30;
                butterfly.vy = 0;
            }
            // برخورد با سقف
            if (butterfly.y < 0) {
                butterfly.y = 0;
                butterfly.vy = 0;
            }

            // ساخت شمع‌های جدید
            frameCount++;
            if (frameCount % 90 === 0) { // هر ۹۰ فریم یک شمع جدید
                let candleY = canvas.height - 30; // شمع روی زمین
                candles.push({ x: canvas.width, y: candleY, width: 20, height: 30 });
            }

            // حرکت شمع‌ها
            candles.forEach((candle, index) => {
                candle.x -= gameSpeed;

                // برخورد پروانه با شمع
                if (
                    butterfly.x < candle.x + 15 &&
                    butterfly.x + 25 > candle.x &&
                    butterfly.y < candle.y + 25 &&
                    butterfly.y + 25 > candle.y
                ) {
                    isGameOver = true;
                    alert("آخ! پروانه به شمع خورد! امتیاز تو: " + score);
                    resetGame();
                }

                // حذف شمع‌های خارج شده
                if (candle.x < -30) {
                    candles.splice(index, 1);
                    score += 10;
                    scoreElement.innerText = score;
                }
            });

            // کمی سخت‌تر شدن بازی
            if (score > 0 && score % 50 === 0) gameSpeed += 0.1;
        }

        function resetGame() {
            butterfly.y = 100; butterfly.vy = 0;
            candles = [];
            score = 0; gameSpeed = 2.5; isGameOver = false; frameCount = 0;
            scoreElement.innerText = score;
        }

        function gameLoop() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            
            // پس زمینه
            ctx.fillStyle = "#1a1a2e";
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            drawCandles();
            drawButterfly();
            updateGame();

            requestAnimationFrame(gameLoop);
        }

        // شروع بازی با لمس یا کلیک
        canvas.addEventListener('click', () => {
            if (!isGameOver) butterfly.vy = butterfly.jump;
        });
        canvas.addEventListener('touchstart', (e) => {
            e.preventDefault();
            if (!isGameOver) butterfly.vy = butterfly.jump;
        });

        // شروع حلقه بازی
        gameLoop();
    </script>
</body>
</html>
