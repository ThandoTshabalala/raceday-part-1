
# RaceDay – Part 2: API Development and Implementation

## Project Overview

RaceDay is an event management system designed to allow organisers to create and manage running events, while participants can register for events, manage their enrolments, and view race results.

This repository contains Part 2 of the RaceDay project completed for the programming module. It focuses on implementing the RaceDay API using C# and ASP.NET Core, including authentication, authorisation, database integration, API functionality, and automated testing.

**Project Type:** Academic Coursework  
**Part:** Part 2 – API Development and Implementation

## Project Objectives

- Implement API functionality for events, categories, enrolments, and race results.
- Implement user registration, login, and role-based access control.
- Connect the API to a SQL Server database using Entity Framework Core.
- Document and test API endpoints using Swagger.
- Use automated tests and GitHub Actions to support build validation.

## Main Features

- User registration, login, and logout.
- Password hashing using ASP.NET Core Identity's `PasswordHasher<User>`.
- Cookie-based authentication and role-based authorisation.
- Event and category management, including organiser ownership checks.
- Participant enrolments and race result management.
- Validation to help prevent duplicate enrolments and results.
- Database connectivity checks.
- Swagger/OpenAPI documentation.
- Automated tests and a GitHub Actions workflow.

## Technologies and Tools

- C# and .NET 8
- ASP.NET Core Web API
- Entity Framework Core
- Microsoft SQL Server
- Swagger / OpenAPI
- xUnit
- Git and GitHub
- GitHub Actions

## Project Structure

The repository contains the API application, automated test project, solution file, and GitHub Actions workflow.

| **File / Folder** | **Description** |
| ----------------- | --------------- |
| `RaceDay.API/Controllers/` | API controllers for authentication, events, categories, enrolments, results, and database connectivity. |
| `RaceDay.API/Data/` | Database context and data-access configuration. |
| `RaceDay.API/Models/` | Application models used by the API. |
| `RaceDay.API.Tests/` | Automated unit tests. |
| `.github/workflows/dotnet.yml` | GitHub Actions workflow for building and testing the solution. |
| `RaceDay.API.slnx` | .NET solution file. |

## API Documentation and Testing

Swagger provides an interactive interface for exploring and testing API endpoints when the application is running in the Development environment. Open `/swagger` using the local address shown by the application.

Run the automated tests from the solution directory using:

```bash
dotnet test RaceDay.API.slnx
```

The GitHub Actions workflow restores dependencies, builds the solution, and runs the tests for configured push and pull-request events.

## Relationship to Part 1

Part 1 established the system plan, API endpoint plan, and SQL Server database design. Part 2 builds on that foundation by implementing the RaceDay API using C# and ASP.NET Core, integrating with SQL Server, and adding authentication, authorisation, and testing.

## Academic Context

This project was completed as part of the PROG6212 programming coursework. The repository is intended for academic portfolio and demonstration purposes, subject to the institution's rules on sharing coursework.

## Learning Outcomes

This project demonstrates experience with:

- Developing RESTful APIs using ASP.NET Core.
- Implementing authentication and role-based authorisation.
- Integrating an API with SQL Server using Entity Framework Core.
- Documenting and testing API endpoints with Swagger.
- Writing and running automated tests.
- Using GitHub Actions for build and test validation.
- Using Git and GitHub for version control and project documentation.
