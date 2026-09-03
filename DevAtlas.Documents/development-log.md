# Development Log

## 2026-08-31 — Initial structure

- Established DataRelay as the architectural and scaffolding reference.
- Created the .NET 10 flat-project solution with numbered virtual solution folders.
- Created empty API, Domain, Application, Infrastructure, Persistence, Jobs, and test boundaries.
- Kept DataRelay-specific business modules out of DevAtlas.
- Created a separate empty Angular UI baseline.
- Recorded undecided product and infrastructure concerns in `architecture.md`.
- Verified backend restore, Release build, and all empty test project boundaries.
- Verified UI formatting, linting, smoke test, and production build.

## 2026-09-03 — Local API experience

- Selected `5000/5001` for DevAtlas API development. DataRelay must be stopped or assigned different
  ports when both APIs are run locally.
- Added first-party ASP.NET Core OpenAPI generation and Swagger UI for Development only.
- Pinned the patched `Microsoft.OpenApi` 2.x release after NuGet audit rejected a vulnerable
  transitive version.
- Configured the local launch profiles to open `/swagger` automatically.
