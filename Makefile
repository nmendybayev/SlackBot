# Building image and running container locally:
docker-dev:
	docker build -t slackbot:v0.1.0-dev -f build/Dockerfile.dev .
docker-prod:
	docker build -t slackbot:v0.1.0-prod -f build/Dockerfile.prod .

run-dev:
	docker run -p 3000:3000 --env-file .env slackbot:v0.1.0-dev
run-prod:
	docker run -p 3000:3000 --env-file .env slackbot:v0.1.0-prod

# Run prod container and check if it works - use README file, Change URL paragraph.
# to stop container: run "docker ps" then "docker stop CONTAINER ID". 
# End of local build and run.


# Creating ECR repository, building and pushing image to AWS ECR:
#variables:
version = v0.1.0
repo = slackbot-prod
account = $(shell aws sts get-caller-identity --query "Account" --output text)
region = us-east-1
aws := aws --region $(region)

# Log in to AWS Account:
login:
	aws ecr get-login-password | docker login --username AWS --password-stdin $(account).dkr.ecr.us-east-1.amazonaws.com
	aws sts get-caller-identity

# Creating ECR repository:
repo:
	aws ecr create-repository --repository-name $(repo) --image-tag-mutability IMMUTABLE

repo-del:
	aws ecr delete-repository --repository-name $(repo) --force

# Building image for pushing to AWS ECR, pushing image to ECR:
docker-production:
	docker build --platform linux/amd64 -t $(repo):$(version) -f build/Dockerfile.prod .
	docker images

login:
	aws ecr get-login-password | docker login --username AWS --password-stdin $(account).dkr.ecr.us-east-1.amazonaws.com

push: login
	docker tag $(repo):$(version) $(account).dkr.ecr.us-east-1.amazonaws.com/$(repo):$(version)
	docker push $(account).dkr.ecr.us-east-1.amazonaws.com/$(repo):$(version)

check_image:
	aws ecr describe-images --repository-name $(repo) --region $(region)