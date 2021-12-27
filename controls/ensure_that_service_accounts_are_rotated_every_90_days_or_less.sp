control "ensure_that_service_accounts_are_rotated_every_90_days_or_less" {
  title = "Ensure that service accounts are rotated every 90 days or less"
  sql = <<EOT
select
row_number() over (order by service_account_name) as resource,
service_account_name,
valid_after_time,
current_timestamp(1) AT TIME ZONE 'Asia/Seoul' -valid_after_time as elapsed_time,
case
when current_timestamp(1) AT TIME ZONE 'Asia/Seoul' -valid_after_time >=  interval '90 day' then 'alarm' else 'ok'
end status,
case 
when current_timestamp(1) AT TIME ZONE 'Asia/Seoul' -valid_after_time >= interval '90 day' then 'This key was created 90 days ago'
else 'This key was created less than 90 days ago'
end reason
from
gcp_service_account_key

where key_type = 'USER_MANAGED'
EOT
}
