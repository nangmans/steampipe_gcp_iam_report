## GCP IAM Report grant_role_to_group Benchmark

Grant roles to a Google group instead of individual users when possible. It is easier to add members to and remove members from a Google group instead of updating an IAM policy to add or remove users.
 
If you need to grant multiple roles to allow a particular task, create a Google group, grant the roles to that group, and then add users to that group.

Reference: https://cloud.google.com/iam/docs/using-iam-securely#policy_management