.PHONY: build clean deploy

build:
	dep ensure
	env GOOS=linux go build -ldflags="-s -w" -o bin/events/create endpoints/events/create/main.go
	env GOOS=linux go build -ldflags="-s -w" -o bin/subscriptions/create endpoints/subscriptions/create/main.go
	env GOOS=linux go build -ldflags="-s -w" -o bin/subscriptions/delete endpoints/subscriptions/delete/main.go
	${GOBIN}\build-lambda-zip.exe -o bin/events/create.zip bin/events/create
	${GOBIN}\build-lambda-zip.exe -o bin/subscriptions/create.zip bin/subscriptions/create
	${GOBIN}\build-lambda-zip.exe -o bin/subscriptions/delete.zip bin/subscriptions/delete

clean:
	rm -rf ./bin ./vendor Gopkg.lock

deploy: clean build
	sls deploy --verbose

# build:
# 	dep ensure
# 	env GOOS=linux go build -ldflags="-s -w" -o main endpoints/events/create/main.go
# 	mkdir -p bin/events
# 	/c/Go/Bin/build-lambda-zip.exe -o bin/events/create.zip main
# 	mv main bin/events/create
# 	env GOOS=linux go build -ldflags="-s -w" -o main endpoints/subscriptions/create/main.go
# 	mkdir -p bin/subscriptions
# 	/c/Go/Bin/build-lambda-zip.exe -o bin/subscriptions/create.zip main
# 	mv main bin/subscriptions/create
# 	env GOOS=linux go build -ldflags="-s -w" -o main endpoints/subscriptions/delete/main.go
# 	mkdir -p bin/subscriptions
# 	/c/Go/Bin/build-lambda-zip.exe -o bin/subscriptions/delete.zip main
# 	mv main bin/subscriptions/delete