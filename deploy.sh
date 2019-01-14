docker build -t ajbenson/multi-client:latest -t ajbenson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajbenson/multi-server:latest -t ajbenson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajbenson/multi-worker:latest -t ajbenson/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ajbenson/multi-client:latest
docker push ajbenson/multi-server:latest
docker push ajbenson/multi-worker:latest

docker push ajbenson/multi-client:$SHA
docker push ajbenson/multi-server:$SHA
docker push ajbenson/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajbenson/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajbenson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajbenson/multi-worker:$SHA