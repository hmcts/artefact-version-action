<div style="display: flex; align-items: center; justify-content: center; gap: 1rem;">
  <img src="./assets/hmcts-logo.png" alt="HM Courts & Tribunals Service logo" width="120" />
  <h1 style="margin: 0;">Artefact Version GitHub Action</h1>
</div>

This GitHub Action generates a draft artefact version string based on the latest Git tag and short SHA.

## 📌 Version Types
This project follows [Semantic Versioning](https://semver.org) (SemVer) conventions.

We support two types of versions:

### 🔧 Draft Versions (on every merge to main or master)
* Triggered by: push to main or master
* Version format: vX.Y.Z-&lt;short-sha&gt;, e.g. v0.2.1-a1b2c3d
    * If no release tag exists, defaults to v0.0.0-&lt;short-sha&gt;
* Purpose: Used for previewing or collaborating on in-progress API definitions.
* Behaviour:
    * The OpenAPI info.version is set automatically.
    * The spec is uploaded to SwaggerHub as:
        * visibility: public
        * published: false

### 🚀 Release Versions (on GitHub release publish)

* Triggered by: Publishing a GitHub release via the UI
* Git tag format: vX.Y.Z (e.g. v1.0.0)
* Version used: X.Y.Z (without the v)
* Purpose: Final, published version of the API for public consumption.
* Behaviour:
    * The OpenAPI info.version is set to the release tag version.
    * The spec is uploaded to SwaggerHub as:
        * visibility: public
        * published: true

## ⚙️ How to Use

### Inputs

- `release`: *(optional)*  
  If set to `true`, uses the Git tag as-is for versioning (e.g., `0.1.4`).  
  If `false` or omitted, appends the short Git SHA to the latest tag (e.g., `0.1.4-a1b2c3d`).

### Outputs

- `draft_version`: Generated version string for draft builds, e.g. `0.1.4-ab12cd3`
- `release_version`: Clean version from Git tag for release builds, e.g. `0.1.4` (strips the `v` prefix)


### Usage

#### 🧪 Draft Mode (default)

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

#### 🚀 Release Mode

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

## Release Custom Action

When creating a new version of this action, it's important to maintain a floating `vX`, e.g. `v1`, tag in addition to the full semantic version tag (e.g., `v1.0.1`).

### Why We Do This

Consumers of this GitHub Action often want to use a floating version, i.e. `@v1`, rather than pinning to a specific version, i.e. `@v1.0.1`.  
This allows them to automatically benefit from bug fixes and minor enhancements without manually upgrading their workflows.

By maintaining the floating tag, we:
- Reduce friction for consumers
- Avoid enforcing unnecessary upgrades
- Support safe iteration and patching within a major version

This helps reduce long-term run and maintain costs across consuming projects.

#### How to Tag

1. Tag and push the new version via the command line or GitHub UI:

   ```bash
   git tag v1.0.1 HEAD
   git push origin v1.0.1
   ```

2. Update the `v1` tag to point to the new release:

   ```bash
   git tag -f v1 v1.0.1
   git push origin v1 --force
   ```

#### Verify

You can verify that `v1` now points to the latest version by visiting:

[https://github.com/hmcts/artefact-version-action/tags](https://github.com/hmcts/artefact-version-action/tags)

Make sure both the full version tag (e.g., `v1.0.1`) and the floating `v1` tag appear, and that `v1` points to the latest commit.

## License

This project is licensed under the [MIT License](LICENSE).
