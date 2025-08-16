<!DOCTYPE html>
<html>
<head>
    <title>Users Database - Docker Stack</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            color: white;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
        }
        th {
            background: rgba(255, 255, 255, 0.2);
            font-weight: bold;
        }
        tr:hover {
            background: rgba(255, 255, 255, 0.1);
        }
        .info {
            text-align: center;
            margin-top: 20px;
            padding: 15px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-link:hover {
            background: #45a049;
        }
        .error {
            background: rgba(244, 67, 54, 0.3);
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .success {
            background: rgba(76, 175, 80, 0.3);
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.php" class="back-link">← Back to Login</a>
        
        <h1>👥 Users Database</h1>
        
        <?php
        try {
            // Connect to database
            $pdo = new PDO('mysql:host=db;dbname=loginapp', 'root', 'password123');
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            
            // Get all users
            $stmt = $pdo->query("SELECT id, username, created_at FROM users ORDER BY id");
            $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            // Get total count
            $countStmt = $pdo->query("SELECT COUNT(*) as total FROM users");
            $totalUsers = $countStmt->fetch(PDO::FETCH_ASSOC)['total'];
            
            echo '<div class="success">✅ Database connection successful! Found ' . $totalUsers . ' users.</div>';
            
            if ($users) {
                echo '<table>';
                echo '<tr><th>ID</th><th>Username</th><th>Created At</th></tr>';
                
                foreach ($users as $user) {
                    echo '<tr>';
                    echo '<td>' . htmlspecialchars($user['id']) . '</td>';
                    echo '<td>' . htmlspecialchars($user['username']) . '</td>';
                    echo '<td>' . htmlspecialchars($user['created_at']) . '</td>';
                    echo '</tr>';
                }
                
                echo '</table>';
            } else {
                echo '<div class="error">No users found in database.</div>';
            }
            
        } catch (PDOException $e) {
            echo '<div class="error">❌ Database connection failed: ' . htmlspecialchars($e->getMessage()) . '</div>';
        }
        ?>
        
        <div class="info">
            <h3>📊 Database Information</h3>
            <p><strong>Database Host:</strong> db</p>
            <p><strong>Database Name:</strong> loginapp</p>
            <p><strong>Table:</strong> users</p>
            <p><strong>Container:</strong> <?php echo gethostname(); ?></p>
            <p><strong>Server Time:</strong> <?php echo date('Y-m-d H:i:s'); ?></p>
        </div>
        
        <div class="info">
            <h3>🔧 SQL Commands for Testing</h3>
            <p><strong>View all users:</strong><br>
            <code>SELECT * FROM users;</code></p>
            
            <p><strong>Count users:</strong><br>
            <code>SELECT COUNT(*) FROM users;</code></p>
            
            <p><strong>Add new user:</strong><br>
            <code>INSERT INTO users (username, password) VALUES ('newuser', 'hashedpassword');</code></p>
        </div>
    </div>
</body>
</html>
