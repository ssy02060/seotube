#!/bin/bash
az aks get-credentials --resource-group seotube --name seotube
#http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/