# dockerfiles

[![Build and Publish Docker image](https://github.com/frezbo/dockerfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/frezbo/dockerfiles/actions/workflows/ci.yml)

Repo for various linux container images.

- [dockerfiles](#dockerfiles)
- [Inspiration](#inspiration)
- [Project Structure](#project-structure)

# Inspiration

* Mostly inspired from [Jess Frazelle's](https://github.com/jessfraz/) [dockerfiles](https://github.com/jessfraz/dockerfiles) repo
* Rebuild public images to remove shell and make it leaner and secure
* Build images for repos that doesn't have a dockerfile
* Automatic dependency updates using [Dependabot](https://docs.github.com/en/github/administering-a-repository/keeping-your-dependencies-updated-automatically)

# Project Structure

* Sample project structure

```tree
.
├── docker-bake.hcl
├── generate_matrix.sh
├── hydroxide
│   ├── Dockerfile
│   ├── go.mod
│   ├── go.sum
│   └── README.md
├── LICENSE
├── README.md
└── vaultwarden
    ├── Dockerfile
    ├── README.md
    └── test.sh

```

Each folder contains a `Dockerfile`, a `README.md`, and an optional `test.sh`

The `go.mod` is used to declare a weak dependency on upstream projects so that [Dependabot](https://docs.github.com/en/github/administering-a-repository/keeping-your-dependencies-updated-automatically) can manage updates.

[`generate_matrix.sh`](../generate_matrix.sh) is used to dynamically generate a [GitHub actions matrix](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstrategy). The matrix is generated only on either `Dockerfile` or `go.mod` file changes.

The container image tags follow the upstream releases. The version is extracted from either `Dockerfile` or `go.mod` by [`generate_matrix.sh`](../generate_matrix.sh) and passed on to *buildx* as `VERSION` *build-arg*. [Ref](../.github/workflows/ci.yml)
