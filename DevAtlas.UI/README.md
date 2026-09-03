# DevAtlas UI

This is the empty Angular 21 UI shell for DevAtlas. It is intentionally free of product features
until their responsibilities and routes are defined.

## Baseline

- standalone components;
- strict TypeScript and Angular template checking;
- zoneless change detection;
- SCSS;
- Vitest;
- ESLint and Prettier.

Generic code belongs under `core`, `shared`, or `layout`. Business code belongs under a named
feature folder only after that feature is documented in `../DevAtlas.Documents/architecture.md`.

## Commands

```powershell
npm start
npm run format:check
npm run lint
npm run test:ci
npm run build
```
