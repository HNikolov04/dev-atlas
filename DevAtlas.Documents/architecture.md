# DevAtlas Architecture Baseline

## Status

This document records the starting architecture for DevAtlas. Keep it synchronized with structural
decisions as the product is defined.

## Reference

DevAtlas begins from the DataRelay repository structure and initialization scripts. That reference
provides the solution shape, project naming, dependency direction, test categories, .NET settings,
and Angular baseline. DevAtlas does not inherit DataRelay product behavior or feature names.

The following DataRelay-specific folders are intentionally absent until DevAtlas features are
defined: `Portal`, `Invoicer`, `PriceLink`, and their UI screens. This prevents product-specific
concepts from becoming accidental DevAtlas architecture.

## Architectural style

The backend is a modular monolith using Clean Architecture. Feature code will be grouped by business
feature inside each layer once the feature boundaries are known.

```text
API -> Application -> Domain
API/Jobs -> DependencyResolution -> Infrastructure/Persistence -> Application/Domain
```

- **Domain** owns entities, domain events, business rules, domain abstractions, and domain services.
  It has no HTTP, database, UI, or vendor dependencies.
- **Application** owns boundary models, use cases, application services, and the abstractions needed
  from outer layers.
- **Infrastructure** implements technical concerns such as email, file storage, external services,
  and messaging.
- **Persistence** owns database configuration, repositories, and migrations.
- **DependencyResolution** is the composition boundary for outer-layer implementations.
- **API** owns HTTP transport concerns and invokes application use cases.
- **Jobs** hosts background processing and invokes application use cases.
- **Common** contains only genuinely cross-cutting primitives; it must not become a miscellaneous
  utilities project.

Dependencies point inward. Domain projects never reference Application, Infrastructure,
Persistence, API, Jobs, or UI. Application projects never reference Infrastructure, Persistence,
API, Jobs, or UI.

## Physical structure

All backend projects use a flat physical layout under `DevAtlas/`. Numbered solution folders provide
the logical grouping without hiding project paths on disk:

```text
00. Solution Items
01. API
02. Core
    01. Domain
    02. Application
03. Infrastructure
04. Persistence
05. Dependency Resolution
06. Common
07. Jobs
08. Tests
```

Tests are split into unit, integration, functional, architecture, end-to-end, and support projects.

## Project ownership

| Project | Responsibility |
| --- | --- |
| `DevAtlas.Api` | HTTP host, controllers, transport models, middleware, and endpoint policy. |
| `DevAtlas.Core.Domain.Entities` | Entities, value objects, and domain behavior. |
| `DevAtlas.Core.Domain.Abstractions` | Domain-owned contracts. |
| `DevAtlas.Core.Domain.Events` | Domain event definitions. |
| `DevAtlas.Core.Domain.Services` | Domain operations that do not belong to one entity. |
| `DevAtlas.Core.Application.Models` | Application boundary models and DTOs. |
| `DevAtlas.Core.Application.Abstractions` | Ports required by application behavior. |
| `DevAtlas.Core.Application.Services` | Reusable application orchestration. |
| `DevAtlas.Core.Application.UseCases` | User- or system-triggered application workflows. |
| `DevAtlas.Infrastructure` | Shared technical implementations used by specialized infrastructure projects. |
| `DevAtlas.Infrastructure.Email` | Email implementations. |
| `DevAtlas.Infrastructure.FileStorage` | File and object storage implementations. |
| `DevAtlas.Infrastructure.ExternalServices` | Third-party service adapters. |
| `DevAtlas.Infrastructure.Messaging` | Message transport and publication implementations. |
| `DevAtlas.Persistence` | Persistence foundation and context-level concerns. |
| `DevAtlas.Persistence.Configurations` | Persisted-entity mappings and configuration. |
| `DevAtlas.Persistence.Repositories` | Repository implementations. |
| `DevAtlas.Persistence.Migrations` | Versioned schema changes. |
| `DevAtlas.DependencyResolution` | Registration and composition of outer-layer implementations. |
| `DevAtlas.Common` | Small, stable primitives shared across inner layers. |
| `DevAtlas.Jobs` | Background-process host. |

Test projects match these boundaries. `DevAtlas.TestData` owns reusable fixtures/builders, while
`DevAtlas.TestUtilities` owns shared test infrastructure.

## UI structure

`DevAtlas.UI` begins as an empty Angular routing shell. Generic UI code is grouped into `core`,
`shared`, and `layout`; product code will be placed below `features/<feature-name>` after the feature
is defined. The UI is a separate deployable and is not added to the .NET solution.

## Baseline conventions

- .NET SDK `10.0.302`, targeting .NET 10.
- Nullable reference types and implicit usings enabled.
- Warnings and code-style violations fail the build.
- NuGet versions are managed centrally.
- StyleCop settings are shared by every backend project.
- The Angular UI is standalone, strict, zoneless, uses SCSS, and is kept outside the .NET solution.
- No business feature folder is added before its responsibility and owner are documented.
- Local ports are stable: UI `4200`, API HTTP `5000`, and API HTTPS `5001`.
- OpenAPI JSON and Swagger UI are exposed only when the API runs in the Development environment.

## Open decisions

The following are deliberately not copied from DataRelay and must be decided for DevAtlas:

- business modules and their boundaries;
- persistence technology and database ownership;
- authentication, authorization, and tenancy model;
- API contracts and versioning;
- background jobs and external integrations;
- UI state management, component library, and localization;
- hosting, deployment, and CI/CD platform.
