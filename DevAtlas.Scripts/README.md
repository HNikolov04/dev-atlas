# DevAtlas Scripts

Scripts in this directory automate repository-wide development tasks. They must resolve paths from
their own location and must not assume a developer-specific checkout path.

## Validate the scaffold

Install UI dependencies once with `npm install` in `DevAtlas.UI`, then run:

```powershell
./DevAtlas.Scripts/Test-DevAtlas.ps1
```

Use `-SkipUi` when only the backend should be validated.
