Chocolatey Simple Server
========================

Docker Hub: https://hub.docker.com/r/srealmuto/chocolatey/

## Overview

Run a chocolatey simple server inside a container.

## How To Use This Image

Download the image:
```
docker pull srealmuto/chocolatey
```

Start the container:
```
docker run -d -p 80:80 --name chocolatey.server srealmuto/chocolatey
```

### Better Yet

Create a data container to store your nupkg files:
```
docker create -v C:/tools/chocolatey.server/App_Data/Packages --name chocolatey.server-data microsoft/nanoserver
```

Start your app container using your data container:
```
docker run -d -p 80:80 --volumes-from chocolatey.server-data --name chocolatey.server srealmuto/chocolatey
```

## Get Chocolatey

Push packages:
```
choco push <nupkg_file> --source=<chocolatey.server_url> --api-key=<api_key> --force
```

Install Packages
```
choco install <package_name> --source=<chocolatey.server_url>/chocolatey/
```
