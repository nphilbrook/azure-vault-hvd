Get the server images for ubuntu 24.04
```
az vm image list --publisher Canonical --all | tee canonical.json # this takes forever
cat canonical.json|jq -C '.[] | select(.version | startswith("24.04")) | select(.offer | contains("airdig") | not) | select(.offer | contains("att") | not) | select(.offer | contains("ub01") | not)| select(.offer | contains("unp") | not) | select(.sku != "cvm")|select(.sku == "server")'|less
```
