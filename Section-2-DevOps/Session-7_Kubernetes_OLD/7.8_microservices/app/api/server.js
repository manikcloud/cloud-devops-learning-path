const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Database connection
const pool = new Pool({
    host: 'database-service',
    port: 5432,
    database: 'todoapp',
    user: 'postgres',
    password: 'password123'
});

// Initialize database table
async function initDatabase() {
    try {
        await pool.query(`
            CREATE TABLE IF NOT EXISTS todos (
                id SERIAL PRIMARY KEY,
                text TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        `);
        console.log('✅ Database table initialized');
    } catch (error) {
        console.error('❌ Database initialization error:', error);
    }
}

// Routes
app.get('/health', (req, res) => {
    res.json({ 
        status: 'healthy', 
        service: 'todo-api',
        timestamp: new Date().toISOString()
    });
});

// Get all todos
app.get('/todos', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM todos ORDER BY created_at DESC');
        res.json(result.rows);
    } catch (error) {
        console.error('Error fetching todos:', error);
        res.status(500).json({ error: 'Database error' });
    }
});

// Add new todo
app.post('/todos', async (req, res) => {
    try {
        const { text } = req.body;
        
        if (!text || text.trim().length === 0) {
            return res.status(400).json({ error: 'Todo text is required' });
        }
        
        const result = await pool.query(
            'INSERT INTO todos (text) VALUES ($1) RETURNING *',
            [text.trim()]
        );
        
        res.status(201).json(result.rows[0]);
    } catch (error) {
        console.error('Error adding todo:', error);
        res.status(500).json({ error: 'Database error' });
    }
});

// Delete todo
app.delete('/todos/:id', async (req, res) => {
    try {
        const { id } = req.params;
        
        const result = await pool.query('DELETE FROM todos WHERE id = $1', [id]);
        
        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Todo not found' });
        }
        
        res.json({ message: 'Todo deleted successfully' });
    } catch (error) {
        console.error('Error deleting todo:', error);
        res.status(500).json({ error: 'Database error' });
    }
});

// Start server
app.listen(port, () => {
    console.log(`🚀 Todo API server running on port ${port}`);
    initDatabase();
});
