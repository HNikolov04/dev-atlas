# DevAtlas Backend

The backend is an empty .NET 10 modular-monolith scaffold derived from the DataRelay structure.
It contains project boundaries and references only; business modules will be added once their
responsibilities are defined.

## Commands

Run from this directory:

```powershell
dotnet restore DevAtlas.slnx
dotnet build DevAtlas.slnx --configuration Release --no-restore
dotnet test DevAtlas.slnx --configuration Release --no-build
```

See [the architecture baseline](../DevAtlas.Documents/architecture.md) for layer ownership and
dependency rules.

## Run locally

```powershell
dotnet run --project DevAtlas.Api --launch-profile https
```

The Development profile opens Swagger UI at `https://localhost:5001/swagger`. The generated OpenAPI
document is available at `https://localhost:5001/openapi/v1.json`. Neither endpoint is exposed
outside the Development environment.
