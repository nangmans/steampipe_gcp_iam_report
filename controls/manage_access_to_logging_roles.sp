control "manage_access_to_logs_using_Logging_roles" {
  title = "Manage access to logs using Logging roles"
  sql = <<EOT
select
row_number() over (order by e) as resource,
RTRIM(split_part(jsonb_array_elements_text(e->'members'),':',2),'"') as member,
split_part(e->>'role','/',2) as role,
case
when e is not null then 'info'
end status,
case
when e is not null then 'Manage access for this user'
end reason

from
gcp_iam_policy as p,
jsonb_array_elements(p.bindings) as e

where
e->> 'role' = 'roles/logging.admin' or
e->> 'role' = 'roles/logging.privateLogViewer' or
e->> 'role' = 'roles/logging.fieldAccessor' or
e->> 'role' = 'logging.bucketWriter' or
e->> 'role' = 'logging.configWriter' or
e->> 'role' = 'logging.logWriter'


EOT
}
