# Teradata Docker
This repository contains the necessary files to create a docker with properly installed Teradata ODBC drivers and python connector. In addition, this docker contains jupyter notebooks for easy exploration.

## Accessing Teradata
We use Teradata's official Python library: `teradata`, and keep connection strings in `idr.ini` file. For more info about teradata package visit [here](https://developer.teradata.com/tools/reference/teradata-python-module).


## Setup Development environment

1. Install Docker for Mac and docker-compose

	`https://docs.docker.com/docker-for-mac/`

	`pip install docker-compose`

2. Build docker with jupyter notebook

	`docker-compose build teradata`

3. Run docker (jupyter notebook acessible on localhost:8888)

	`docker-compose up teradata's`