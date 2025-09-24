# Microservices Application: Container Orchestration, Scaling & Load Balancing

## Project Overview

This project demonstrates a containerized microservices architecture using **Docker Compose** with horizontal scaling, load balancing via **NGINX**, resilience testing, and monitoring using **cAdvisor**.

**Services:**

* **Flask API (`api/`)**: Exposes `/api/health` and `/api/data` endpoints, supports scaling (replicas), returns container info and timestamps.
* **NGINX (`nginx.conf`)**: Load balances `/api` requests to API containers using least-connections.
* **Postgres & Redis**: Backend services for future integration (defined in Compose, not directly used in API).
* **Web Frontend (`web/`)**: Static HTML served by NGINX.
* **cAdvisor**: Container metrics available at `localhost:8080`.

**Ports:**

* API: `5000`
* NGINX: `80`
* cAdvisor: `8080`

---

## Project Structure

```
microservices-app/
├── api/
│   ├── Dockerfile
│   └── app.py
├── web/
│   ├── Dockerfile
│   └── index.html
├── docker-compose.yml
├── nginx.conf
├── test-scaling.sh
├── test-resilience.sh
├── README.md
└── .gitignore
```

---

## Key Workflows

### Build & Run

* Build and start all services:

```bash
docker-compose up -d --build
```

* Scale API service:

```bash
docker-compose up -d --scale api=3
```

### Testing

* Run scaling tests:

```bash
./test-scaling.sh
```

* Run resilience tests:

```bash
./test-resilience.sh
```

* Load testing uses ApacheBench (`ab`) with concurrent requests.

### Monitoring & Debugging

* API logs: `docker-compose logs api`
* NGINX logs: `docker-compose logs nginx`
* Container stats: `http://localhost:8080` (cAdvisor)
* Check running containers: `docker ps`

---

## Patterns & Conventions

* API endpoints are under `/api/`
* Environment variable `APP_VERSION` injected into API containers
* API service designed for horizontal scaling; NGINX proxies across all replicas
* No direct DB/Redis logic yet
* NGINX container is named `loadbalancer`

---

## Integration Points

* **NGINX ↔ API**: NGINX proxies `/api` requests to `api` service via service discovery
* **API ↔ Environment**: Reads `APP_VERSION` and container hostname for endpoints
* **Monitoring**: cAdvisor provides real-time container metrics

---

## Examples

* Add new API endpoint: edit `api/app.py`, rebuild API image
* Modify load balancing: edit `nginx.conf`, restart NGINX

---

## 🤖 GitHub Copilot Reflection

### ✅ Accepted Suggestions

* `api/app.py` routes `/api/health` and `/api/data`
* Healthchecks in `docker-compose.yml`

### ❌ Rejected Suggestions

* **Dockerfile base image:** Copilot suggested `FROM python:latest`; we use `python:3.9-slim` for reproducible builds
* **NGINX upstream servers:** Copilot suggested hardcoding multiple servers; Compose resolves replicas automatically
* **Database seeding script:** Not required for this assignment

### 💡 Key Takeaways

* Copilot is excellent for scaffolding repetitive code
* Always review suggestions for security, maintainability, and assignment alignment
* Rejecting suggestions demonstrates deliberate engineering decisions

---

## 🎬 Video Demo Notes

1. Show project structure & architecture
2. Build & run services: `docker-compose up -d --build`
3. Show API health (`/api/health`) & metrics (`/metrics`), NGINX proxying, cAdvisor dashboard
4. Demonstrate scaling: 1 → 3 → 5 replicas using `ab` results
5. Demonstrate resilience: kill one API container & show automatic recovery
6. Optional: Docker Swarm deployment, scale, and rolling update
7. Mention Copilot reflection
8. Cleanup: `docker-compose down`

---

## References

* Docker Compose documentation: [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
* Docker Swarm guide: [https://docs.docker.com/engine/swarm/](https://docs.docker.com/engine/swarm/)
* NGINX load balancing: [https://nginx.org/en/docs/http/load\_balancing.html](https://nginx.org/en/docs/http/load_balancing.html)
* Container best practices: [https://12factor.net/](https://12factor.net/)
