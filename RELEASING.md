# Releases

The release version is stored in the root VERSION file.

## Publish after merging

1. Update VERSION in the release PR, for example from 2.6.1 to 2.6.2.
2. Review the PR and wait for the desired checks before merging into main.
3. Merging a VERSION change triggers Publish release. The workflow tags the triggering commit and publishes a GitHub release with generated notes.

Ordinary merges that do not change VERSION do not publish releases. The release workflow does not itself wait for lint or enforce branch protection. Configure required checks on main if publication must follow passing CI.

## Manual publication

Run Publish release from GitHub Actions and select the intended branch or tag. Leave version blank to read VERSION at that ref, or supply an explicit version. The release target is the selected run commit. Explicit versions do not update VERSION.

## Reuse from another workflow

```yaml
jobs:
  release:
    permissions:
      contents: write
    uses: ./.github/workflows/release.yml
    with:
      version: '2.6.2'
```

Omit version to read VERSION at the caller commit. The workflow also exposes release_url as an output. It can be referenced from another repository using the normal owner/repository workflow path and an appropriate ref; publication uses the caller repository and its GITHUB_TOKEN permissions.

## Version and safety behavior

- Accepts two- or three-component numeric versions, optionally prefixed with v and optionally followed by a prerelease suffix. Examples: 2.6, 2.6.2, v2.7.0, 2.7.0-rc.1.
- Versions with a prerelease suffix are published as prereleases.
- Existing releases are left unchanged.
- An existing tag without a release must point to the triggering commit; otherwise publication fails rather than moving the tag.
- Publication is serialized per repository to prevent concurrent release creation races.
- No checkout or project-code execution is required.
- GitHub Actions must be enabled and allowed to grant contents: write to the workflow token.

The legacy release-2.6.1.yml filename remains only as a manual wrapper. It no longer hard-codes a version or runs on pushes.
