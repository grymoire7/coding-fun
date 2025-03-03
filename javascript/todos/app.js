// Constants
const API_URL = 'https://jsonplaceholder.typicode.com/todos';
const USER_ID = 1;

// DOM Elements
const tasksList = document.getElementById('tasks-list');
const newTaskInput = document.getElementById('new-task-input');
const addTaskButton = document.getElementById('add-task-button');
const searchInput = document.getElementById('search-input');
const searchButton = document.getElementById('search-button');
const clearSearchButton = document.getElementById('clear-search');
const filterStatus = document.getElementById('filter-status');
const loadingElement = document.getElementById('loading');
const errorElement = document.getElementById('error');

// State
let tasks = [];
let filteredTasks = [];
let currentFilter = 'all';
let searchTerm = '';

// Event Listeners
document.addEventListener('DOMContentLoaded', initApp);
addTaskButton.addEventListener('click', addNewTask);
newTaskInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        e.preventDefault();
        addNewTask();
    }
});
searchButton.addEventListener('click', searchTasks);
searchInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        e.preventDefault();
        searchTasks();
    }
});
clearSearchButton.addEventListener('click', clearSearch);
filterStatus.addEventListener('change', filterTasks);

// Initialize the application
async function initApp() {
    showLoading(true);
    try {
        await fetchTasks();
        renderTasks();
    } catch (error) {
        showError('Failed to load tasks. Please try again later.');
        console.error('Error initializing app:', error);
    } finally {
        showLoading(false);
    }
}

// Fetch tasks from the API
async function fetchTasks() {
    try {
        const response = await fetch(`${API_URL}?userId=${USER_ID}`);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        tasks = await response.json();
        filteredTasks = [...tasks];
    } catch (error) {
        console.error('Error fetching tasks:', error);
        throw error;
    }
}

// Render tasks to the DOM
function renderTasks() {
    tasksList.innerHTML = '';
    
    if (filteredTasks.length === 0) {
        const noTasksMessage = document.createElement('li');
        noTasksMessage.textContent = 'No tasks found';
        noTasksMessage.className = 'no-tasks-message';
        tasksList.appendChild(noTasksMessage);
        return;
    }
    
    filteredTasks.forEach(task => {
        const taskItem = createTaskElement(task);
        tasksList.appendChild(taskItem);
    });
}

// Create a task element
function createTaskElement(task) {
    const taskItem = document.createElement('li');
    taskItem.className = `task-item ${task.completed ? 'task-completed' : ''}`;
    taskItem.dataset.id = task.id;
    
    const checkbox = document.createElement('input');
    checkbox.type = 'checkbox';
    checkbox.className = 'task-checkbox';
    checkbox.checked = task.completed;
    checkbox.addEventListener('change', () => toggleTaskStatus(task.id, checkbox.checked));
    
    const taskTitle = document.createElement('span');
    taskTitle.className = 'task-title';
    taskTitle.textContent = task.title;
    
    const actionsDiv = document.createElement('div');
    actionsDiv.className = 'task-actions';
    
    const editButton = document.createElement('button');
    editButton.className = 'edit-btn';
    editButton.textContent = 'Edit';
    editButton.addEventListener('click', () => startEditingTask(taskItem, task));
    
    const deleteButton = document.createElement('button');
    deleteButton.className = 'delete-btn';
    deleteButton.textContent = 'Delete';
    deleteButton.addEventListener('click', () => deleteTask(task.id));
    
    actionsDiv.appendChild(editButton);
    actionsDiv.appendChild(deleteButton);
    
    taskItem.appendChild(checkbox);
    taskItem.appendChild(taskTitle);
    taskItem.appendChild(actionsDiv);
    
    return taskItem;
}

// Add a new task
async function addNewTask() {
    const title = newTaskInput.value.trim();
    if (!title) {
        showError('Task title cannot be empty');
        return;
    }
    
    showLoading(true);
    try {
        const newTask = {
            title,
            completed: false,
            userId: USER_ID
        };
        
        const response = await fetch(API_URL, {
            method: 'POST',
            body: JSON.stringify(newTask),
            headers: {
                'Content-type': 'application/json; charset=UTF-8',
            },
        });
        
        if (!response.ok) {
            throw new Error('Failed to create task');
        }
        
        const createdTask = await response.json();
        
        // JSONPlaceholder doesn't actually create the resource on the server,
        // so we'll add it to our local array with a unique ID
        createdTask.id = Date.now(); // Generate a unique ID
        tasks.unshift(createdTask);
        
        newTaskInput.value = '';
        applyFiltersAndSearch();
        
    } catch (error) {
        showError('Failed to add task. Please try again.');
        console.error('Error adding task:', error);
    } finally {
        showLoading(false);
    }
}

// Toggle task completed status
async function toggleTaskStatus(taskId, completed) {
    showLoading(true);
    try {
        const response = await fetch(`${API_URL}/${taskId}`, {
            method: 'PATCH',
            body: JSON.stringify({
                completed
            }),
            headers: {
                'Content-type': 'application/json; charset=UTF-8',
            },
        });
        
        if (!response.ok) {
            throw new Error('Failed to update task');
        }
        
        // Update local state
        const taskIndex = tasks.findIndex(task => task.id === taskId);
        if (taskIndex !== -1) {
            tasks[taskIndex].completed = completed;
            applyFiltersAndSearch();
        }
    } catch (error) {
        showError('Failed to update task status. Please try again.');
        console.error('Error updating task status:', error);
    } finally {
        showLoading(false);
    }
}

// Start editing a task
function startEditingTask(taskItem, task) {
    const taskTitle = taskItem.querySelector('.task-title');
    const actionsDiv = taskItem.querySelector('.task-actions');
    
    // Create edit form
    const editForm = document.createElement('form');
    editForm.className = 'task-edit-form';
    editForm.addEventListener('submit', (e) => {
        e.preventDefault();
        saveTaskEdit(task.id, editInput.value);
    });
    
    const editInput = document.createElement('input');
    editInput.type = 'text';
    editInput.className = 'task-edit-input';
    editInput.value = task.title;
    
    const saveButton = document.createElement('button');
    saveButton.type = 'submit';
    saveButton.textContent = 'Save';
    
    const cancelButton = document.createElement('button');
    cancelButton.type = 'button';
    cancelButton.textContent = 'Cancel';
    cancelButton.addEventListener('click', () => {
        taskItem.replaceChild(taskTitle, editForm);
        taskItem.appendChild(actionsDiv);
    });
    
    editForm.appendChild(editInput);
    actionsDiv.innerHTML = '';
    actionsDiv.appendChild(saveButton);
    actionsDiv.appendChild(cancelButton);
    
    taskItem.replaceChild(editForm, taskTitle);
}

// Save task edit
async function saveTaskEdit(taskId, newTitle) {
    if (!newTitle.trim()) {
        showError('Task title cannot be empty');
        return;
    }
    
    showLoading(true);
    try {
        const response = await fetch(`${API_URL}/${taskId}`, {
            method: 'PATCH',
            body: JSON.stringify({
                title: newTitle
            }),
            headers: {
                'Content-type': 'application/json; charset=UTF-8',
            },
        });
        
        if (!response.ok) {
            throw new Error('Failed to update task');
        }
        
        // Update local state
        const taskIndex = tasks.findIndex(task => task.id === taskId);
        if (taskIndex !== -1) {
            tasks[taskIndex].title = newTitle;
            applyFiltersAndSearch();
        }
    } catch (error) {
        showError('Failed to update task. Please try again.');
        console.error('Error updating task:', error);
    } finally {
        showLoading(false);
    }
}

// Delete a task
async function deleteTask(taskId) {
    if (!confirm('Are you sure you want to delete this task?')) {
        return;
    }
    
    showLoading(true);
    try {
        const response = await fetch(`${API_URL}/${taskId}`, {
            method: 'DELETE',
        });
        
        if (!response.ok) {
            throw new Error('Failed to delete task');
        }
        
        // Update local state
        tasks = tasks.filter(task => task.id !== taskId);
        applyFiltersAndSearch();
        
    } catch (error) {
        showError('Failed to delete task. Please try again.');
        console.error('Error deleting task:', error);
    } finally {
        showLoading(false);
    }
}

// Search tasks
function searchTasks() {
    searchTerm = searchInput.value.trim().toLowerCase();
    applyFiltersAndSearch();
}

// Clear search
function clearSearch() {
    searchInput.value = '';
    searchTerm = '';
    applyFiltersAndSearch();
}

// Filter tasks
function filterTasks() {
    currentFilter = filterStatus.value;
    applyFiltersAndSearch();
}

// Apply filters and search
function applyFiltersAndSearch() {
    filteredTasks = tasks.filter(task => {
        // Apply status filter
        if (currentFilter === 'completed' && !task.completed) return false;
        if (currentFilter === 'active' && task.completed) return false;
        
        // Apply search filter
        if (searchTerm && !task.title.toLowerCase().includes(searchTerm)) return false;
        
        return true;
    });
    
    renderTasks();
}

// Show/hide loading indicator
function showLoading(show) {
    loadingElement.style.display = show ? 'block' : 'none';
}

// Show error message
function showError(message) {
    errorElement.textContent = message;
    errorElement.classList.remove('hidden');
    
    // Hide error after 3 seconds
    setTimeout(() => {
        errorElement.classList.add('hidden');
    }, 3000);
}
