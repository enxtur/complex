docker build -t enxtur/multi-client:latest -t enxtur/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t enxtur/multi-server:latest -t enxtur/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t enxtur/multi-worker:latest -t enxtur/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push enxtur/multi-client:latest
docker push enxtur/multi-server:latest
docker push enxtur/multi-worker:latest
docker push enxtur/multi-client:$SHA
docker push enxtur/multi-server:$SHA
docker push enxtur/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=enxtur/multi-server:$SHA
kubectl set image deployments/client-deployment client=enxtur/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=enxtur/multi-worker:$SHA