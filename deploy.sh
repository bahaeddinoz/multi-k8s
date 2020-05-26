docker build -t bahaoz/multi-client:latest -t bahaoz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bahaoz/multi-server:latest -t bahaoz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bahaoz/multi-worker:latest -t bahaoz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bahaoz/multi-client:latest
docker push bahaoz/multi-server:latest
docker push bahaoz/multi-worker:latest

docker push bahaoz/multi-client:$SHA
docker push bahaoz/multi-server:$SHA
docker push bahaoz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bahaoz/multi-server:$SHA
kubectl set image deployments/client-deployment client=bahaoz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bahaoz/multi-worker:$SHA

