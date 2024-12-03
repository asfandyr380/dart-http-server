# Dart HTTP Server with ServerSocket 🚀

A simple and fun project to dive into Dart's `ServerSocket` for creating an HTTP server from scratch! This project is perfect for learning the fundamentals of server programming in Dart while having some weekend coding fun.

## Features 🌟

- **Custom HTTP server** built using `ServerSocket`.
- Handles basic HTTP requests (GET, POST, etc.).
- Lightweight and simple to understand.
- Perfect for learning and experimenting.

## How It Works ⚙️
- The server listens for incoming TCP connections using Dart's ServerSocket.
- It parses HTTP requests manually and sends appropriate responses.
- Designed with simplicity for educational purposes, focusing on core concepts.

## Getting Started 🔧

### Prerequisites
- Dart SDK installed (version 3.0.0 or higher recommended). 
- A code editor of your choice (e.g., VSCode, IntelliJ, etc.).

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/dart-http-server.git
2. CD into project
    ```bash
    cd dart-http-server
### Running the Server
1. Run the Dart script
   ```bash
   dart run main.dart
2. Your server will start listening on the configured port (default: 3000).
    Access it via your browser or tools like curl
    ```bash
    curl http://localhost:3000