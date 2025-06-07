# Artefact Version GitHub Action

This GitHub Action generates a draft artefact version string based on the latest Git tag and short SHA.

## Outputs

- `draft_version`: e.g., `0.1.4-ab12cd3`
- `latest_tag`: e.g., `0.1.4` (strips the `v` prefix)

## Usage

```yaml
- name: Generate Version
  id: version
  uses: your-org/artefact-version-action@v1
```

You can then use the outputs like this:

```yaml
echo "Version is ${{ steps.version.outputs.draft_version }}"
```
