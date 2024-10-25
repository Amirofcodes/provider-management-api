# Provider Management API

A Symfony 6.4 API application for managing service providers and their services, built following the 12-Factor App methodology.

## 12-Factor App Compliance

1. **Codebase**: One codebase tracked in Git, many deploys
2. **Dependencies**: Explicitly declare and isolate dependencies
3. **Config**: Store config in the environment
4. **Backing Services**: Treat backing services as attached resources
5. **Build, release, run**: Strictly separate build and run stages
6. **Processes**: Execute the app as one or more stateless processes
7. **Port binding**: Export services via port binding
8. **Concurrency**: Scale out via the process model
9. **Disposability**: Maximize robustness with fast startup and graceful shutdown
10. **Dev/prod parity**: Keep development, staging, and production as similar as possible
11. **Logs**: Treat logs as event streams
12. **Admin processes**: Run admin/management tasks as one-off processes

## Prerequisites

- PHP 8.3
- Composer
- Docker & Docker Compose
- MySQL 5.7
- Redis

## Installation

1. Clone the repository

```bash
git clone [repository-url]
cd provider-management-api
```

2. Install dependencies

```bash
composer install
```

3. Configure environment

```bash
cp .env.example .env
# Edit .env with your local configuration
```

4. Start Docker services

```bash
docker-compose up -d
```

5. Run database migrations

```bash
php bin/console doctrine:migrations:migrate
```

## Development

### Running Tests

```bash
php bin/phpunit
```

### API Documentation

#### Providers Endpoints

- `GET /providers` - List all providers
- `POST /providers` - Create a new provider
- `PUT /providers/{id}` - Update a provider
- `DELETE /providers/{id}` - Delete a provider

#### Services Endpoints

- `GET /services` - List all services
- `POST /services` - Create a new service
- `PUT /services/{id}` - Update a service
- `DELETE /services/{id}` - Delete a service

## Contributing

Please follow the Git commit conventions and ensure all tests pass before submitting a pull request.
