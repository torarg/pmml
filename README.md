# poor man's mailing list (pmml)

## Description
Fetches IMAP inboxes via fetchmail and forwards recieved mails to a list of
recipients.

# Usage
First you will need to write configuration files for pmml and fetchmail. Feel
free to use the supplied examples as starting point:
- example_configs/pmmlrc
- example_configs/fetchmailrc

## Docker

```
docker run -v $(pwd)/example_configs/fetchmailrc:/.fetchmailrc -v $(pwd)/example_configs/pmmlrc:/.pmmlrc -it pmml:0.1.4
```

## Kubernetes
If using kubernetes the configuration files should be injected as secret into
the pod executing pmml.

First create the secrets:
```
kubectl create secret generic pmml-pmmlrc --from-file example_configs/pmmlrc -n pmml
```

```
kubectl create secret generic pmml-fetchmailrc --from-file example_configs/fetchmailrc -n pmml
```

Afterwards create the deployment:
```
kubectl -n pmml apply -f example_configs/pmml_deployment.yml
```

## Updating secrets
After updating either of the supplied secrets you will need to restart the
pmml pod:
```
kubectl -n pmml delete pod $(kubectl -n pmml get pods | tail -1 | awk '{print $1}')
```
