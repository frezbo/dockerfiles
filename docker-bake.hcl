variable "CONTEXT" {}

variable "DOCKERFILE" {}

variable "VERSION" {}

variable "LOAD_IMAGE_IN_CI" {}

target "ghaction-docker-meta" {}

target "build" {
  inherits   = ["ghaction-docker-meta"]
  context    = "${CONTEXT}"
  dockerfile = "${DOCKERFILE}"
  args = {
    VERSION = "${VERSION}"
  }
  cache-from = ["type=registry,ref=ghcr.io/frezbo/builder-cache:latest"]
  cache-to   = ["type=inline"]
  platforms = equal("${LOAD_IMAGE_IN_CI}", "true") ? ["linux/amd64"] : [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v6",
    "linux/arm/v7"
  ]
}
