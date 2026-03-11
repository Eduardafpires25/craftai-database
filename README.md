# CraftAI - E-commerce Personalization Platform

## Overview

CraftAI is a web-based platform for e-commerce personalization powered by AI. The platform allows users to describe custom products, generate AI-powered visual previews, review and approve results, and convert approved projects into formal orders.

## Architecture

The system consists of four main components:

1. **Frontend** - React SPA with authentication and responsive UI
2. **Backend** - Java Spring Boot REST API with JWT security
3. **AI Service** - Python FastAPI microservice for image generation
4. **Database** - PostgreSQL with normalized relational schema

## Project Structure

```
CraftAI/
├── backend/                 # Spring Boot Java application
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── com/
│   │   │   │       └── craftai/
│   │   │   │           ├── CraftAiApplication.java
│   │   │   │           ├── config/
│   │   │   │           ├── controller/
│   │   │   │           ├── dto/
│   │   │   │           ├── entity/
│   │   │   │           ├── repository/
│   │   │   │           ├── service/
│   │   │   │           └── security/
│   │   │   └── resources/
│   │   └── test/
│   ├── pom.xml
│   └── application.yml
├── frontend/               # React application
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── services/
│   │   ├── hooks/
│   │   ├── contexts/
│   │   ├── utils/
│   │   ├── App.js
│   │   └── index.js
│   ├── package.json
│   └── .env
├── ai-service/            # Python FastAPI service
│   ├── app/
│   │   ├── __init__.py
│   │   ├── main.py
│   │   ├── models/
│   │   ├── routes/
│   │   ├── services/
│   │   └── config/
│   ├── requirements.txt
│   └── .env
├── database/              # Database schema and migrations
│   ├── schema.sql
│   └── seed_data.sql
└── docker-compose.yml     # Container orchestration
```

## Technology Stack

### Frontend
- React 18
- React Router
- Axios
- Tailwind CSS
- JWT token management

### Backend
- Java 17
- Spring Boot 3
- Spring Security
- Spring Data JPA
- JWT authentication
- PostgreSQL driver

### AI Service
- Python 3.9+
- FastAPI
- Pillow (for image processing)
- Requests (for external APIs)

### Database
- PostgreSQL 14+

## Core Features

1. **User Management**
   - Registration and login
   - JWT-based authentication
   - Role-based access (CUSTOMER, SELLER, ADMIN)

2. **Project Creation**
   - Custom product description
   - Category, style, color palette selection
   - Size and additional notes

3. **AI Preview Generation**
   - Integration with AI service
   - Multiple preview versions
   - Regeneration capability

4. **Review and Approval**
   - Preview visualization
   - Edit and regenerate workflow
   - Approval mechanism

5. **Order Management**
   - Convert approved projects to orders
   - Order status tracking
   - Seller dashboard

## API Endpoints

### Authentication
- POST /api/auth/register
- POST /api/auth/login
- GET /api/auth/me

### Projects
- POST /api/projects
- GET /api/projects
- GET /api/projects/{id}
- PUT /api/projects/{id}
- DELETE /api/projects/{id}

### AI Generation
- POST /api/projects/{id}/generate
- GET /api/projects/{id}/previews
- POST /api/projects/{id}/regenerate
- POST /api/projects/{id}/approve/{previewId}

### Orders
- POST /api/projects/{id}/create-order
- GET /api/orders
- GET /api/orders/{id}
- PUT /api/orders/{id}/status

### Seller Dashboard
- GET /api/seller/projects
- GET /api/seller/orders

## Database Schema

### Core Tables
- users
- stores
- product_categories
- custom_projects
- generated_previews
- orders

## Setup Instructions

### Prerequisites
- Java 17+
- Node.js 16+
- Python 3.9+
- PostgreSQL 14+

### Running the Application

1. **Database Setup**
   ```bash
   # Create database
   createdb craftai
   
   # Run schema
   psql craftai < database/schema.sql
   
   # Run seed data (optional)
   psql craftai < database/seed_data.sql
   ```

2. **Backend**
   ```bash
   cd backend
   mvn spring-boot:run
   ```

3. **AI Service**
   ```bash
   cd ai-service
   pip install -r requirements.txt
   uvicorn app.main:app --reload
   ```

4. **Frontend**
   ```bash
   cd frontend
   npm install
   npm start
   ```

### Docker Setup (Alternative)
```bash
docker-compose up -d
```

## Environment Variables

### Backend (.env)
```
DB_URL=jdbc:postgresql://localhost:5432/craftai
DB_USERNAME=postgres
DB_PASSWORD=password
JWT_SECRET=your-secret-key
AI_SERVICE_URL=http://localhost:8000
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:8080/api
```

### AI Service (.env)
```
OPENAI_API_KEY=your-openai-key (optional)
```

## Security Features

- JWT token-based authentication
- Password hashing with BCrypt
- Role-based access control
- Input validation and sanitization
- CORS configuration
- Protected API endpoints

## Development Notes

- The AI service can work with external providers or return mock images
- All services are designed to be independently scalable
- Database uses normalized schema for data integrity
- Frontend follows component-based architecture
- Backend implements layered architecture pattern

## Future Enhancements

- Real-time notifications
- Advanced AI model integration
- Payment gateway integration
- Multi-store support
- Advanced analytics dashboard
- Mobile application
