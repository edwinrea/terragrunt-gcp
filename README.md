## Quick start


Configure your GCP access credenctials as environment variables:

```
export GCP_CREDENTIAL=/path/to/json/file.json
```

Configure project id as a environment vairable

```
export TF_VAR_project_id=(desired project id)
```


Configure the database name and credentials as environment variables:

```
export TF_VAR_db_name=(desired database name)
export TF_VAR_db_username=(desired database username)
export TF_VAR_db_password=(desired database password)
```



Deploy the code:

```
terragrunt apply-all --terragrunt-non-interactive
```

To destroy all:

```
terragrunt destroy-all
```
