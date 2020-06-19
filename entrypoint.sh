#!/bin/sh -l
#-------------------------------------------------------------------------------
#  Copyright 2017 Pax, Schweizerische Lebensversicherungs-Gesellschaft AG
#
#  Licensed under the Pax License, Version 1.0 (the "License");
#-------------------------------------------------------------------------------
#
# @Description
# create docker image and push it to a registry
# we use SEMVER.org for tag's
#-------------------------------------------------------------------------------

echo "Pax GitHub Automation - create image and push to registry"

# some github repositories contain uppercase letters
# docker image names require lowercase letters only
INPUT_GITREPO_LOWERCASE=`echo "$INPUT_GITREPO" | awk '{ print tolower($1) }'`

# dockerfile filename (optional argument handling)
DOCKERFILE="Dockerfile";
if [ ! -z "$INPUT_DOCKERFILE" ]; then
    DOCKERFILE=$INPUT_DOCKERFILE;
fi

# buildcontext path (optional argument handling)
BUILDCONTEXT=".";
if [ ! -z "$INPUT_BUILDCONTEXT" ]; then
    BUILDCONTEXT=$INPUT_BUILDCONTEXT;
fi

# buildarg arguments (optional argument handling)
BUILDARG="";
if [ ! -z "$INPUT_BUILDARG" ]; then
    BUILDARG="--build-arg $INPUT_BUILDARG";
fi

# create image name and imagetag
# Strip git ref prefix from version
VERSION=$(echo "$INPUT_GITREF" | sed -e 's,.*/\(.*\),\1,')
# Strip "v" prefix from tag name
[[ "$INPUT_GITREF" == "refs/tags/"* ]] && VERSION=$(echo $VERSION | sed -e 's/^v//')
# Use Docker `latest` tag convention
[ "$VERSION" == "master" ] && VERSION=latest

IMAGE_ID="$INPUT_GITREPO_LOWERCASE/$INPUT_IMAGENAME"

# login to registry
echo "$INPUT_REGISTRYTOKEN" | docker login $INPUT_REGISTRYNAME -u $INPUT_REGISTRYUSER --password-stdin

# build docker image
docker build $BUILDARG -t $IMAGE_ID -f $DOCKERFILE $BUILDCONTEXT || exit 1

# push image
docker tag $IMAGE_ID "$INPUT_REGISTRYNAME/$IMAGE_ID:$VERSION" || exit 1
docker push "$INPUT_REGISTRYNAME/$IMAGE_ID:$VERSION" || exit 1

# exit with image name
echo ::set-output name=image::$IMAGE_ID:$VERSION
echo ::set-output name=tag::$VERSION
