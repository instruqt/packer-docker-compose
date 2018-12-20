# Packer recipe for Docker compose based setups

Usage: Create a directory inside `files/compose` where you put your Docker Compose
files. You can add multiple directories, which will result in multiple services.

Afterwards, run make PROJECT_ID=$YOURPROJECT build
