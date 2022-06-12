# Release process

Releases are done **manually**.

Automation may be introduced, but currently they're not that much of an issue.
 
## Rules

1. Releases are only created from `main`.
1. `main` is meant to be stable, so before tagging and create a new release, make sure that the CI checks pass.
1. Releases are GitHub releases.
1. Releases are following *semantic versioning*.
1. Releases are to be named in pattern of `vX.Y.Z`. The produced binary artifacts contain the `vX.Y.Z` in their names.
1. Changelog must up-to-date with what's going to be released.
1. **Make sure** to bump the version of `istioctlenv`. Bumping the version of `istioctl-build` is often omitted.

## Flow

1. Create a new GitHub release using https://github.com/hatappi/istioctlenv
1. `Tag Version` and `Release Title` are going to be in pattern of `vX.Y.Z`.
