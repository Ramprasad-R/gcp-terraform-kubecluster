#!/bin/bash
terraform init
terraform apply -auto-approve
terraform output master-ip  | grep -o '".*"' | sed 's/"//g' > master_node.yaml
terraform output worker-ip  | grep -o '".*"' | sed 's/"//g' > worker_node.yaml

export MASTER_IP=`terraform output master-ip  | grep -o '".*"' | sed 's/"//g'`

ssh -i gcpkey ubuntu@$MASTER_IP -o StrictHostKeyChecking=no cat /tmp/kube_join.sh > join_kube.sh

chmod +x join_kube.sh

for i in `cat worker_node.yaml`
do
	ssh -i gcpkey ubuntu@$i -o StrictHostKeyChecking=no sudo 'bash -s' < join_kube.sh
done
rm -f join_kube.sh master_node.yaml worker_node.yaml

ssh -i gcpkey ubuntu@$MASTER_IP -o StrictHostKeyChecking=no kubectl get nodes