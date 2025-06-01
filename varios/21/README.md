# Demo GitHub Actions con Tests

[![Node.js CI](https://github.com/pablokbs/peladonerd/actions/workflows/tests.yml/badge.svg)](https://github.com/pablokbs/peladonerd/actions/workflows/tests.yml)
[![Integration Tests](https://github.com/pablokbs/peladonerd/actions/workflows/integration-tests.yml/badge.svg)](https://github.com/pablokbs/peladonerd/actions/workflows/integration-tests.yml)
![Coverage](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/pablokbs/04afb0f414aa2cc4dd88a133454c7947/raw/coverage.json)

Este proyecto es una demostración de GitHub Actions que incluye:

- Tests unitarios en Node.js
- Tests de integración en Python con PostgreSQL
- Reporte de cobertura de código

## Estructura

- `src/` - Aplicación Node.js con tests unitarios
- `integration/` - Tests de integración con PostgreSQL

## Tests Unitarios (Node.js)

```bash
cd src
npm install
npm test
```

## Tests de Integración (Python)

```bash
cd integration
pip install -r requirements.txt
pytest -v
```

## Cobertura de Código

Los tests de integración incluyen reporte de cobertura que se puede ver:
- En los Pull Requests como comentario
- En el badge del README
- En detalle en los artifacts de GitHub Actions 