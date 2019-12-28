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

# build docker image
docker build . --file $DFILE --tag image

# login to registry
echo "$INPUT_REGISTRYTOKEN" | docker login $INPUT_REGISTRYNAME -u $INPUT_REGISTRYUSER --password-stdin

# push image
IMAGE_ID="$INPUT_REGISTRYNAME/$INPUT_GITREPO/$INPUT_IMAGENAME"
docker push $IMAGE_ID:$INPUT_IMAGETAG || exit 1

# exit with image name
echo ::set-output name=image::$IMAGE_ID:$INPUT_IMAGETAG
