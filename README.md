# wait-docker-image-github-action
A simple Github Action waiting for a Docker image.

## Inputs

### Required
#### `image`
_String_
The name of the image to wait for.

### Optional
#### `tag`
_String_
Optional tag for the image, default: `latest`

#### `timeout`
_Integer_
Timeout in seconds, default: `3600`

#### `fail-on-timeout`
_Boolean_
Wether to fail the job or not if the timeout is over, default: `true`

#### `user`
_String_
Registry user to use.

#### `password`
_String_
Registry password to use.

## Example usage
Example usage to wait for ubuntu:18.04 image to be available, if the image is not available after 1 minute, the job does not fail and continues.
```
uses: PaulLesur/wait-docker-image-github-action@v1.0
with:
    image: ubuntu
    tag: 18.04
    timeout: 60
    fail-on-timeout: false
```