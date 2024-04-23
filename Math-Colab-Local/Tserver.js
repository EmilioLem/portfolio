// server.js

const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

// Serve static files from the public directory
app.use(express.static('public'));

// Store the current LaTeX code
let sharedText = '';

// Socket.io connection handler
io.on('connection', (socket) => {
    console.log('A user connected');

    // Send the current shared text to the client
    socket.emit('updateSharedText', sharedText);

    // Listen for updates from the client
    socket.on('updateSharedText', (data) => {
        sharedText = data;
        // Broadcast the updated shared text to all clients
        io.emit('updateSharedText', sharedText);
    });

    // Handle disconnection
    socket.on('disconnect', () => {
        console.log('A user disconnected');
    });
});

// Start the server
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});



/*const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

// Serve static files from the public directory
app.use(express.static('public'));

// Store the current LaTeX code
let latexCode = '';

// Socket.io connection handler
io.on('connection', (socket) => {
    console.log('A user connected');

    // Send the current LaTeX code to the client
    socket.emit('updateLatex', latexCode);

    // Listen for updates from the client
    socket.on('updateLatex', (data) => {
        latexCode = data;
        // Broadcast the updated LaTeX code to all clients
        io.emit('updateLatex', latexCode);
    });

    // Handle disconnection
    socket.on('disconnect', () => {
        console.log('A user disconnected');
    });
});

// Start the server
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});*/
