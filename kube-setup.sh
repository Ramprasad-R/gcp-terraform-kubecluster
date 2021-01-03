#!/bin/bash
terraform init
terraform apply -auto-approve
export MASTER_IP=`terraform output master-ip  | grep -o '".*"' | sed 's/"//g'`
terraform output worker-ip  | grep -o '".*"' | sed 's/"//g' > worker_node.yaml

ssh -i gcpkey ubuntu@$MASTER_IP -o StrictHostKeyChecking=no cat /tmp/kube_join.sh > join_kube.sh

chmod +x join_kube.sh

for i in `cat worker_node.yaml`
do
	ssh -i gcpkey ubuntu@$i -o StrictHostKeyChecking=no sudo 'bash -s' < join_kube.sh
done

rm -f join_kube.sh worker_node.yaml

ssh -i gcpkey ubuntu@$MASTER_IP -o StrictHostKeyChecking=no kubectl get nodes