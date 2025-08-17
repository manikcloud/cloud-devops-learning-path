// Simple JavaScript for Todo App
const API_BASE = '/api';

// Load todos when page loads
document.addEventListener('DOMContentLoaded', function() {
    loadTodos();
    
    // Add todo on Enter key
    document.getElementById('todoInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            addTodo();
        }
    });
});

// Load all todos from API
async function loadTodos() {
    try {
        showStatus('Loading todos...', 'loading');
        
        const response = await fetch(`${API_BASE}/todos`);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const todos = await response.json();
        displayTodos(todos);
        hideStatus();
        
    } catch (error) {
        console.error('Error loading todos:', error);
        showStatus('❌ Error loading todos. Is the API service running?', 'error');
        document.getElementById('todos').innerHTML = '<div class="empty-state">Failed to load todos</div>';
    }
}

// Add new todo
async function addTodo() {
    const input = document.getElementById('todoInput');
    const text = input.value.trim();
    
    if (!text) {
        showStatus('⚠️ Please enter a todo!', 'error');
        return;
    }
    
    try {
        showStatus('Adding todo...', 'loading');
        
        const response = await fetch(`${API_BASE}/todos`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ text: text })
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        input.value = '';
        showStatus('✅ Todo added!', 'success');
        setTimeout(hideStatus, 2000);
        loadTodos();
        
    } catch (error) {
        console.error('Error adding todo:', error);
        showStatus('❌ Error adding todo. Check API service.', 'error');
    }
}

// Delete todo
async function deleteTodo(id) {
    try {
        showStatus('Deleting todo...', 'loading');
        
        const response = await fetch(`${API_BASE}/todos/${id}`, {
            method: 'DELETE'
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        showStatus('✅ Todo deleted!', 'success');
        setTimeout(hideStatus, 2000);
        loadTodos();
        
    } catch (error) {
        console.error('Error deleting todo:', error);
        showStatus('❌ Error deleting todo.', 'error');
    }
}

// Display todos in the UI
function displayTodos(todos) {
    const todosContainer = document.getElementById('todos');
    
    if (todos.length === 0) {
        todosContainer.innerHTML = '<div class="empty-state">🎉 No todos yet! Add one above to get started.</div>';
        return;
    }
    
    todosContainer.innerHTML = todos.map(todo => `
        <div class="todo">
            <span class="todo-text">${escapeHtml(todo.text)}</span>
            <button class="delete-btn" onclick="deleteTodo(${todo.id})">Delete</button>
        </div>
    `).join('');
}

// Show status message
function showStatus(message, type) {
    const status = document.getElementById('status');
    status.textContent = message;
    status.className = `status ${type}`;
    status.style.display = 'block';
}

// Hide status message
function hideStatus() {
    const status = document.getElementById('status');
    status.style.display = 'none';
}

// Escape HTML to prevent XSS
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}
