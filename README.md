# jsdoc-builder-action

JSDoc Builder Action is a GitHub Action that builds [JSDoc](https://jsdoc.app/) documentation from your JavaScript codebases and centralizes them into a single repository.

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
        uses: eutiveumsonho/jsdoc-builder-action@v1
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