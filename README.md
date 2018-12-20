# Packer recipe for Docker compose based setups

This packer recipe creates a GCP Compute image, that runs one or more docker-compose stacks as systemd services.

## Usage

Create a directory inside `files/compose` where you put your Docker Compose files. The name of the directory will be used to create a systemd service called `docker-compose@<dir_name>.service`.

You can add multiple directories, which will result in multiple services.

To build the image, run `make PROJECT_ID=$YOUR_PROJECT IMAGE_NAME=$YOUR_IMAGE build`. You must be authenticated with `gcloud`, and have the rights to create compute instances and images in `$YOUR_PROJECT`.
