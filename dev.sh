$(aws ecr get-login --no-include-email --region ap-southeast-1)

aws s3 sync assets s3://bryce-assets/grapefruit/ --acl public-read
docker build -t grapefruit .
docker kill grapefruit
docker rm grapefruit
#docker run -d --name grapefruit -p 8080:8080 grapefruit
docker run -d --name grapefruit -p 8080:8080 grapefruit
docker tag grapefruit:latest 650143975734.dkr.ecr.ap-southeast-1.amazonaws.com/trendsh-uno-grapefruit:latest
docker push 650143975734.dkr.ecr.ap-southeast-1.amazonaws.com/trendsh-uno-grapefruit:latest

