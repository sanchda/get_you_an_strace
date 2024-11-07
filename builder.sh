#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 [alpine|ubuntu]"
    exit 1
fi

if [ "$1" == "alpine" ]; then
    DOCKERFILE="Dockerfile.alpine"
    IMAGE_NAME="alpine-strace"
elif [ "$1" == "ubuntu" ]; then
    DOCKERFILE="Dockerfile.ubuntu"
    IMAGE_NAME="ubuntu-strace"
else
    echo "Invalid option. Use 'alpine' or 'ubuntu'."
    exit 1
fi

docker build -t "$IMAGE_NAME" . -f "$DOCKERFILE" && \
docker run --rm -v "$PWD":/mnt "$IMAGE_NAME" sh -c "
    # Find the path of strace
    STRACE_PATH=\$(which strace)

    # Copy strace binary to mounted directory
    cp \$STRACE_PATH /mnt/
"
mv strace strace.$1
