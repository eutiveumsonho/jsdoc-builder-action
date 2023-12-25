[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/eutiveumsonho/jsdoc-builder-action/fork)

# jsdoc-builder-action

JSDoc Builder Action is a GitHub Action that builds [JSDoc](https://jsdoc.app/) documentation from your JavaScript codebases and centralizes them into a single repository.

## Why this action?

Documentation is a critical part of any project. It helps developers understand the codebase and how to use it. However, it is often neglected and ends up being outdated or even inexistent. At eutiveumsonho, we believe that documentation is a first-class citizen and should be treated as such. That's why we created this action. It allows you to generate documentation from your codebase and centralize it into a single repository. This way, you can keep your documentation up-to-date and easily accessible.

To check out an example of this action in action, take a look at [docs.eutiveumsonho.com](https://docs.eutiveumsonho.com).

## Configuration

This action requires an `API_TOKEN_GITHUB` environment variable to be set. This token should have access to the repository where the documentation will be pushed and the repositories which it will generate documentation from.

It can be configured using the following parameters:

| Option                                       | Description                                                                                              | Default value                                  |
| -------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `jsdoc-input-files`                          | Input files for jsdoc                                                                                    | -                                              |
| `destination-github-username`                | Name of the destination username/organization                                                            | -                                              |
| `destination-repository-name`                | Destination repository                                                                                   | -                                              |
| `destination-repository-username` (Optional) | Username/organization for the destination repository                                                     | -                                              |
| `user-name` (Optional)                       | Name for the git commit                                                                                  | `github-actions[bot]`                          |
| `user-email` (Optional)                      | Email for the git commit                                                                                 | `github-actions[bot]@users.noreply.github.com` |
| `target-branch` (Optional)                   | Target branch name for the destination repository                                                        | `main`                                         |
| `commit-message`                             | Commit message for the output repository. ORIGIN_COMMIT is replaced by the URL@commit in the origin repo | `docs: update docs ORIGIN_COMMIT`              |

## Example usage

For a thorough explanation of the configuration options, please refer to the [action.yml](./action.yml) file.

```yaml
# .github/workflows/docs.yml
name: Generate docs

on:
  push:
    branches:
      - main

jobs:
  generate-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Generate docs
        uses: eutiveumsonho/jsdoc-builder-action@main
        env:
          API_TOKEN_GITHUB: ${{ secrets.DOCS_GEN_GH_TOKEN }}
        with:
          jsdoc-input-files: "./components/ ./containers/ ./lib/ ./app/ ./package.json"
          destination-github-username: "eutiveumsonho"
          destination-repository-name: "docs"
          user-name: marcelovicentegc
          user-email: marcelovicentegc@gmail.com
          target-branch: main
          commit-message: "docs: update docs ORIGIN_COMMIT"
```

> Actual configuration from one of the projects from @eutiveumsonho