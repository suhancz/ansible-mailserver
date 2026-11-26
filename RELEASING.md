# How to make a release

A release is a named snapshot of this project. Think of it as putting a label on a finished box: people can download that exact version later.

The VERSION file contains the label. GitHub does the publishing for you.

## The normal way: change one number, then merge

1. Open VERSION. It contains one line, such as 3.0.0.
2. For a small fix, increase the last number: 3.0.0 becomes 3.0.1. For a big change that breaks old setups, increase the first number and set the others to 0, like the step from 2.6.2 to 3.0.0.
3. Put that change in the same pull request as the changes you want to release. A pull request is a proposed change that can be reviewed before it becomes part of the main project.
4. Review the changes and wait for the checks you require to pass.
5. Merge the pull request into main.
6. Open the repository's Actions tab and look for Publish release.
7. When it succeeds, open Releases. Your new version should be there with automatically written release notes.

You do not need to edit the workflow for each release.

Merging changes without changing VERSION does not publish a release. There is only one release workflow: .github/workflows/release.yml.

## What happens behind the scenes?

When VERSION changes on main, GitHub reads the number from the merged code. It creates a tag, which is a label pointing to that exact commit, and a release page with a list of changes. It does not install anything on your server.

If the release already exists, GitHub leaves it alone. It does not overwrite its notes or move its tag. If a tag exists without a release but points to different code, the workflow stops instead of silently changing it.

## Publish by hand

Use this if you need to retry publication, for example after a failed run.

1. Open Actions in GitHub.
2. Select Publish release.
3. Click Run workflow.
4. Choose the branch or tag containing the code you want to release. Normally choose main.
5. Run it, wait for success, then check Releases.

The workflow always publishes the version written in the VERSION file of the code you chose. You cannot type a version into the Run workflow form, because the security checks of this project do not allow inputs there. To publish another version, change VERSION first.

## Test releases

For an unfinished version, put a label such as 3.1.0-rc.1 into VERSION. The workflow marks it as a prerelease so people can see that it is not a normal finished release.

Labels can have two or three number parts, such as 3.1 or 3.1.0. A leading v is also accepted, such as v3.1.0. Stick to one style to avoid confusing people.

## If it does not work

- Open the failed Publish release run in Actions and read the error.
- Check that VERSION contains only the intended version label.
- Check that GitHub Actions is enabled and the workflow is allowed to write repository contents. That permission is needed to create tags and releases.
- Check whether that release or tag already exists.

The workflow does not wait for lint checks by itself. Require checks before merging if you want to prevent releases of code that has not passed them.

## Optional: call it from another workflow

You can ignore this section if you only use the steps above.

Another GitHub workflow can call the same publishing job instead of copying it:

```yaml
jobs:
  release:
    permissions:
      contents: write
    uses: ./.github/workflows/release.yml
    with:
      version: "3.0.1"
```

Leave out version to read VERSION from the caller's commit. The job returns release_url, the link to the release page.

Other repositories can call it with an owner/repository workflow reference and a chosen ref. It publishes in the calling repository using that repository's permissions.
