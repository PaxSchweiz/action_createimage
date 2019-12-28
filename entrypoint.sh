#!/bin/sh -l
#-------------------------------------------------------------------------------
#  Copyright 2017 Pax, Schweizerische Lebensversicherungs-Gesellschaft AG
#
#  Licensed under the Pax License, Version 1.0 (the "License");
#-------------------------------------------------------------------------------
#
# @Description
# create docker image and push it to a registry
#
#-------------------------------------------------------------------------------

echo "Pax GitHub Automation - create image and push to registry"

# dockerfile filename (optional argument handling)
if [ -z "$INPUT_DOCKERFILE" ]; then
    DFILE="Dockerfile";
  else DFILE=$INPUT_DOCKERFILE;
fi

IMAGE_ID="$INPUT_GITREPO/$INPUT_IMAGENAME"

# login to registry
echo "$INPUT_REGISTRYTOKEN" | docker login $INPUT_REGISTRYNAME -u $INPUT_REGISTRYUSER --password-stdin

# build docker image
docker build -t $IMAGE_ID -f $DFILE . || exit 1

# push image
docker tag $IMAGE_ID "$INPUT_REGISTRYNAME/$IMAGE_ID:$INPUT_IMAGETAG" || exit 1
docker push "$INPUT_REGISTRYNAME/$IMAGE_ID:$INPUT_IMAGETAG" || exit 1

# exit with image name
echo ::set-output name=image::$IMAGE_ID:$INPUT_IMAGETAG
