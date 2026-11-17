# 🐳 Inception

## 🧩 Overview

The **Inception** project is part of the 42 curriculum and focuses on system administration and infrastructure management using **Docker**.

The goal is to build a small infrastructure from scratch, consisting of multiple Docker containers running together to host a **WordPress website**.

The project introduces containerization, service orchestration, network configuration, persistent storage, and secure communication between services.

## 🧱 Project Goals

- Understand **Docker** and containerization concepts.
- Build custom Docker images using **Dockerfiles**.
- Orchestrate multiple services using **Docker Compose**.
- Configure and manage a **Nginx** web server.
- Deploy **WordPress** with **PHP-FPM**.
- Set up and manage a **MariaDB** database.
- Establish secure communication using **TLS/SSL certificates**.
- Configure Docker networks and persistent volumes.
- Manage environment variables and Docker secrets.

## ⚙️ Implemented Services

| Service | Description |
|---------|-------------|
| **Nginx** | Web server responsible for handling HTTPS connections and forwarding requests to WordPress |
| **WordPress** | Content management system used to host and manage the website |
| **MariaDB** | Relational database used to store WordPress data |
| **Docker Compose** | Orchestrates the different containers and their dependencies |
| **Docker Volumes** | Ensure persistent storage for database and WordPress files |
| **Docker Network** | Allows containers to communicate through an isolated network |
| **Docker Secrets** | Provides a way to manage sensitive credentials |

## 🏗️ Infrastructure Architecture

The infrastructure consists of three independent containers connected through a private Docker network.

Each service has a specific responsibility:

- **Nginx** acts as the entry point, accepting HTTPS connections on port `443`.
- **WordPress** processes website requests through PHP-FPM.
- **MariaDB** stores the website's data and manages database operations.

Nginx communicates with WordPress, which in turn interacts with MariaDB.

Persistent volumes ensure that website files and database information remain available even when containers are restarted.

## 🔄 How It Works

When a user accesses the website:

1. The browser establishes a secure HTTPS connection with Nginx.
2. Nginx receives the request and forwards PHP requests to WordPress.
3. WordPress processes the request and retrieves the necessary information from MariaDB.
4. The generated response is returned through Nginx to the browser.

Docker Compose manages the lifecycle of the containers, their network connections, and their dependencies.

## 🧠 Concepts Learned

Through this project, I learned how to:

- Create and manage isolated environments using **Docker containers**.
- Build custom images with **Dockerfiles**.
- Orchestrate multi-container applications using **Docker Compose**.
- Configure web servers and reverse proxy functionality with **Nginx**.
- Deploy and configure WordPress and MariaDB.
- Manage persistent data using Docker volumes and bind mounts.
- Configure private networks for inter-container communication.
- Implement HTTPS using TLS/SSL certificates.
- Handle sensitive information using environment variables and Docker secrets.
- Understand the fundamentals of infrastructure deployment and system administration.

## 🚀 Running the Infrastructure

Build and start the infrastructure:

```bash
make
```

Once all containers are running, access the website through:

```text
https://your_domain_name
```

The domain name must match the configuration in the `.env` file.

