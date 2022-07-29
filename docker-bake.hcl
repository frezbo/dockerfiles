variable "CONTEXT" {}

variable "DOCKERFILE" {}

variable "VERSION" {}

variable "LOAD_IMAGE_IN_CI" {}

target "docker-metadata-action" {}

target "build" {
  inherits   = ["docker-metadata-action"]
  context    = "${CONTEXT}"
  dockerfile = "${DOCKERFILE}"
  args = {
    VERSION = "${VERSION}"
  }
  cache-from = ["type=gha"]
  cache-to   = ["type=gha,mode=max"]
  platforms = equal("${LOAD_IMAGE_IN_CI}", "true") ? ["linux/amd64"] : [
    "linux/amd64",
    "linux/arm/v7"
  ]
}
