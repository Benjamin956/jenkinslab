#!/bin/bash

# Make required directories in the docker container
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Copy data from our host system to the docker container
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Create a dockerfile to automate the container creation process
echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python /home/myapp/sample_app.py" >> tempdir/Dockerfile

# Build and run the container using the dockerfile above.
cd tempdir
# Create an image from the dockerfile
docker build -t sampleapp .
# Run the image
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
# Check that the container got created
docker ps -a 


