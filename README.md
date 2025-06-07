<div style="display: flex; align-items: center; justify-content: center; gap: 1rem;">
  <img src="./assets/hmcts-logo.png" alt="HM Courts & Tribunals Service logo" width="120" />
  <h1 style="margin: 0;">Artefact Version GitHub Action</h1>
</div>

This GitHub Action generates a draft artefact version string based on the latest Git tag and short SHA.

## Inputs

- `release`: *(optional)*  
  If set to `true`, uses the Git tag as-is for versioning (e.g., `0.1.4`).  
  If `false` or omitted, appends the short Git SHA to the latest tag (e.g., `0.1.4-a1b2c3d`).

## Outputs

- `draft_version`: Generated version string for draft builds, e.g. `0.1.4-ab12cd3`
- `release_version`: Clean version from Git tag for release builds, e.g. `0.1.4` (strips the `v` prefix)

## Usage

### 🧪 Draft Mode (default)

```yaml
- name: Generate Version
  id: artefact
  uses: hmcts/artefact-version-action@v1
```

Access with:

```yaml
${{ steps.artefact.outputs.draft_version }}
```

---

### 🚀 Release Mode

```yaml
- name: Generate Release Version
  id: artefact
  uses: hmcts/artefact-version-action@v1
  with:
    release: true
```

Access with:

```yaml
${{ steps.artefact.outputs.release_version }}
```

## License

This project is licensed under the [MIT License](LICENSE).
