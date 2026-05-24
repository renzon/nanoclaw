#!/bin/bash
# Build the beancount agent container image
# Usage: ./container/images/beancount/build.sh
#
# To update dependencies: copy fresh Pipfile/Pipfile.lock from the project,
# then re-run this script.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

IMAGE_NAME="nanoclaw-agent-beancount"
TAG="${1:-latest}"

# Copy latest Pipfile/Pipfile.lock from source project
FINANCE_PROJECT="$PROJECT_ROOT/../contabilidade-pessoal"
if [ -f "$FINANCE_PROJECT/Pipfile" ]; then
  cp "$FINANCE_PROJECT/Pipfile" "$FINANCE_PROJECT/Pipfile.lock" "$SCRIPT_DIR/"
  echo "Updated Pipfile from contabilidade-pessoal"
fi

echo "Building beancount agent image..."
echo "Image: ${IMAGE_NAME}:${TAG}"

docker build -t "${IMAGE_NAME}:${TAG}" "$SCRIPT_DIR"

echo ""
echo "Build complete!"
echo "Image: ${IMAGE_NAME}:${TAG}"
