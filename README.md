# Push image to registry action

This action pushes an image to the registry.

## Inputs

### `gitrepo`

**Required** name of the git repository - only the name not a full URL

### `registryname`

**Required** registry hostname FQDN

### `registryuser`

**Required** registry user / actor

### `registrytoken`

**Required** registry token / password

### `imagetag`

**Required** tag to be used on image

### `imagename`

**Required** image name

### `dockerfile`

Dockerfile filename - default is "Dockerfile"

## Outputs

### `name`

The full URL to the container image on the registry

## Example usage

uses: paxactions/createimage
with:
  gitrepo: 'myrepo'
  registryname: 'docker.pkg.github.com'
  registryuser: 'xy'
  registrytoken: 'sdfsdafasdfsdafasdf'
  imagetag: '1.3.2'
  imagename: 'usually_same_as_repo_name'
