# pnpm-publish

[![GitHub Action](https://img.shields.io/github/actions/workflow/status/raviqqe/pnpm-publish/test.yaml?branch=main&style=flat-square)](https://github.com/raviqqe/pnpm-publish/actions)
[![License](https://img.shields.io/github/license/raviqqe/pnpm-publish.svg?style=flat-square)](https://github.com/raviqqe/pnpm-publish/blob/main/LICENSE)

A GitHub Action to run `pnpm publish`.

## Concurrency

After publishing packages, the action waits until the registry serves their new versions so that the next workflow run does not publish the same versions again. To make the next run start after that, queue workflow runs with the `concurrency` field.

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  queue: max
```

## License

[The Unlicense](UNLICENSE)
