# Push image to registry action

This action pushes an image to the registry. See [action metadata](action.yml)

## Example usage
```yaml
uses: PaxSchweiz/action_createimage@1.0.0
with:
  gitrepo: 'myrepo'
  registryname: 'docker.pkg.github.com'
  registryuser: ${{ github.actor }}
  registrytoken: ${{ secrets.GITHUB_TOKEN }}
  gitref: ${{ github.ref }}
  imagename: 'usually_same_as_repo_name'
```
