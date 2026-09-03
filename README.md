# DevAtlas

DevAtlas follows the structural baseline of DataRelay: a .NET modular monolith organized with
Clean Architecture, plus a separate Angular UI. The repository starts intentionally empty of
business features so that DevAtlas terminology and module boundaries can be introduced explicitly.

## Repository layout

- `DevAtlas/` — .NET solution, API, jobs host, architectural layers, and tests.
- `DevAtlas.UI/` — Angular application.
- `DevAtlas.Documents/` — architecture and project documentation.
- `DevAtlas.Scripts/` — repeatable development and initialization scripts.
- `DevAtlas.DevOps/` — deployment and infrastructure assets.

Read [the architecture baseline](DevAtlas.Documents/architecture.md) before adding backend
projects or changing dependency directions.

## Validate

```powershell
dotnet restore DevAtlas/DevAtlas.slnx
dotnet build DevAtlas/DevAtlas.slnx --configuration Release --no-restore
dotnet test DevAtlas/DevAtlas.slnx --configuration Release --no-build

Push-Location DevAtlas.UI
npm run format:check
npm run lint
npm run test:ci
npm run build
Pop-Location
```

## Local addresses

- UI: `http://localhost:4200`
- API: `https://localhost:5001` (`http://localhost:5000` is also bound locally)
- Swagger UI: `https://localhost:5001/swagger`
- OpenAPI document: `https://localhost:5001/openapi/v1.json`
