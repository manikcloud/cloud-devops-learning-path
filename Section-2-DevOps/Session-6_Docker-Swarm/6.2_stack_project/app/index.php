<!DOCTYPE html>
<html>
<head>
    <title>Docker Stack Login App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 50px;
            color: white;
        }
        .container {
            max-width: 400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 16px;
        }
        input[type="text"]::placeholder, input[type="password"]::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        button {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 10px;
        }
        button:hover {
            background: #45a049;
        }
        .register-btn {
            background: #2196F3;
        }
        .register-btn:hover {
            background: #1976D2;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
        }
        .success {
            background: rgba(76, 175, 80, 0.3);
        }
        .error {
            background: rgba(244, 67, 54, 0.3);
        }
        .info {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐝 Docker Stack Login</h1>
        
        <?php
        $message = '';
        $messageType = '';
        
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $username = $_POST['username'] ?? '';
            $password = $_POST['password'] ?? '';
            $action = $_POST['action'] ?? '';
            
            if ($username && $password) {
                try {
                    $pdo = new PDO('mysql:host=db;dbname=loginapp', 'root', 'password123');
                    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                    
                    if ($action == 'register') {
                        // Register new user
                        $stmt = $pdo->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
                        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
                        $stmt->execute([$username, $hashedPassword]);
                        $message = "User registered successfully!";
                        $messageType = 'success';
                    } else {
                        // Login user
                        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
                        $stmt->execute([$username]);
                        $user = $stmt->fetch();
                        
                        if ($user && password_verify($password, $user['password'])) {
                            $message = "Login successful! Welcome, " . htmlspecialchars($username);
                            $messageType = 'success';
                        } else {
                            $message = "Invalid username or password!";
                            $messageType = 'error';
                        }
                    }
                } catch (PDOException $e) {
                    $message = "Database error: " . $e->getMessage();
                    $messageType = 'error';
                }
            } else {
                $message = "Please fill in all fields!";
                $messageType = 'error';
            }
        }
        ?>
        
        <?php if ($message): ?>
            <div class="message <?php echo $messageType; ?>">
                <?php echo $message; ?>
            </div>
        <?php endif; ?>
        
        <form method="POST">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Enter username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>
            
            <button type="submit" name="action" value="login">Login</button>
            <button type="submit" name="action" value="register" class="register-btn">Register</button>
        </form>
        
        <div class="info">
            <p><strong>Container:</strong> <?php echo gethostname(); ?></p>
            <p><strong>Server:</strong> <?php echo $_SERVER['SERVER_NAME']; ?></p>
            <p>This app demonstrates Docker Stack with PHP + MySQL</p>
        </div>
    </div>
</body>
</html>
