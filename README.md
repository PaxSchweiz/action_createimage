# Push image to registry action

This action pushes an image to the registry. See [action metadata](action.yml)

## Example usages
```yaml
uses: PaxSchweiz/action_createimage@1.1.0
with:
  gitrepo: 'myrepo'
  registryname: 'docker.pkg.github.com'
  registryuser: ${{ github.actor }}
  registrytoken: ${{ secrets.GITHUB_TOKEN }}
  gitref: ${{ github.ref }}
  imagename: 'usually_same_as_repo_name'
```

```yaml
uses: PaxSchweiz/action_createimage@1.1.0
with:
  gitrepo: 'myrepo'
  registryname: 'docker.pkg.github.com'
  registryuser: ${{ github.actor }}
  registrytoken: ${{ secrets.GITHUB_TOKEN }}
  gitref: ${{ github.ref }}
  imagename: 'usually_same_as_repo_name'
  dockerfile: ./docker/one_of_many_images/Dockerfile
  buildcontext: ./docker/one_of_many_images/
  buildarg: ARG_SPECIFIED_IN_DOCKERFILE=some_value
```
