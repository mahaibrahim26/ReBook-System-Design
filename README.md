# ReBook — Book Exchange System Design

A community-based book exchange platform designed as a Software Engineering 
team project at SRH Berlin.

## Project Overview

ReBook enables users to register, list books, search and request exchanges, 
communicate through in-app messaging, and receive notifications — all managed 
through a structured 3-tier architecture.

The focus of this repository is the **system design and engineering documentation** 
behind the platform.

---

## SDLC Model — Agile (Scrum)

The project follows an Agile Scrum methodology, organized into 5 two-week sprints:

| Sprint | Weeks  | Goal                        |
|--------|--------|-----------------------------|
| 1      | 1–2    | User registration & login   |
| 2      | 3–4    | Book listing & search       |
| 3      | 5–6    | Exchange system & chat      |
| 4      | 7–8    | Admin features              |
| 5      | 9–10   | Testing & final fixes       |

Agile was chosen for its flexibility, iterative delivery, and continuous feedback 
cycles — better suited than Waterfall or Spiral for an evolving feature set.

---

## Architecture — 3-Tier Design

The system is divided into three logical layers:

**Presentation Layer** — Flutter (Mobile UI)
- Handles user interactions, forms, and notifications
- Communicates with backend via REST API (HTTP GET/POST)

**Business Logic Layer** — FastAPI (Python)
- Processes exchange requests, validates user actions
- Manages messaging and notification logic
- Acts as mediator between UI and database

**Data Layer** — PostgreSQL + SQLAlchemy ORM
- Stores users, books, and exchange records
- Manages relationships and CRUD operations
- Enforces referential integrity via foreign keys

Design principles applied: High Cohesion, Loose Coupling, Abstraction, Reusability.

---

## UML Diagrams

### Behavioral
- **Use Case Diagram** — user and admin interactions, external authentication 
  and notification services
- **Activity Diagram** — book exchange flow across 3 swimlanes 
  (User, System, Book Owner)
- **Sequence Diagram** — message flow between User, ExchangeService, 
  NotificationService, and Database

### Structural
- **Class Diagram** — key classes: User, Book, Exchange, Message, 
  Notification, Admin
- **Object Diagram** — concrete runtime instance of a book exchange request 
  between two users

---

## Testing Strategy

**Functional Testing:**

| Module        | What is Tested                          |
|---------------|-----------------------------------------|
| Authentication| Register, login, logout, password rules |
| Books         | List, search, filter, view details      |
| Exchange      | Create, accept, decline, status updates |
| Profile       | Edit profile, view books, history       |
| Database      | Models, relationships, cascade deletes  |

**Non-Functional Testing:**
- Performance: API responses under 2s for 50 concurrent users
- Security: password hashing, no direct DB access from UI
- Compatibility: Android, iOS, Chrome (Flutter web build)

Testing is integrated into every sprint — unit tests daily, feature tests 
mid-sprint, regression and UAT at sprint end.

---

## Project Management

- Methodology: Agile Scrum with 2-week sprints
- Tools: GitHub, Figma, Trello/Jira, Teams
- Roles: Project Manager, Developers, Tester, Designer, Documentation Lead

---

## Repository Contents

- `Book Exchange.pdf` — Full project presentation (PDF)
- `reBook_backend/` — FastAPI backend (team project)
- `rebook_frontend/` — Flutter frontend (team project)

---

## Technologies

Flutter • FastAPI • PostgreSQL  • REST APIs • Agile Scrum • UML
