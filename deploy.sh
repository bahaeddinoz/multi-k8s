docker build -t bahaeddinoz/multi-client:latest -t bahaeddinoz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bahaeddinoz/multi-server:latest -t bahaeddinoz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bahaeddinoz/multi-worker:latest -t bahaeddinoz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bahaeddinoz/multi-client:latest
docker push bahaeddinoz/multi-server:latest
docker push bahaeddinoz/multi-worker:latest

docker push bahaeddinoz/multi-client:$SHA
docker push bahaeddinoz/multi-server:$SHA
docker push bahaeddinoz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bahaeddinoz/multi-server:$SHA
kubectl set image deployments/client-deployment client=bahaeddinoz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bahaeddinoz/multi-worker:$SHA

