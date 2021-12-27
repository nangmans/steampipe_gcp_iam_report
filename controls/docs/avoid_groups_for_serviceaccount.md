## GCP IAM Report avoid_groups_for_serviceaccount Benchmark

Service accounts are intended to be used by applications. It's rare that multiple applications perform the same function and therefore have similar or identical access requirements. Instead, applications tend to be unique and the resources they require access to are typically different for each application.

References : https://cloud.google.com/iam/docs/best-practices-for-securing-service-accounts#groups

