flask-app 경로 하에서 진행함

# docker build
docker build -t flask-app .

# docker run
docker run --name flask-app-image -p 5100:5100 flask-app