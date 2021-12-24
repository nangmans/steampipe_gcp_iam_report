control "avoid_user_managed_service_account_keys" {
  title = "avoid user-managed service account keys and to use other methods"
  sql = <<EOT
select
row_number() over (order by service_account_name) as resource,
service_account_name,
key_type,
case
when key_type is not null then 'alarm'
else 'OK'
end status,
case
when key_type is not null then 'Avoid user-managed service account keys'
end reason
from gcp_service_account_key
where key_type = 'USER_MANAGED'


EOT
}
