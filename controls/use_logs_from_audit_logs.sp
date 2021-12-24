control "use_logs_from_cloud_audit_logs" {
  title = "Use logs from Cloud Audit Logs to regularly audit changes to your IAM policy"
  sql = <<EOT
with result as (
select
service,
case
when audit_log_configs #>> '{}' LIKE '%ADMIN_READ%' then 'On'
else 'Off'
end ADMIN_READ,
case
when audit_log_configs #>> '{}' LIKE '%DATA_READ%' then 'On'
else 'Off'
end DATA_READ,
case
when audit_log_configs #>> '{}' LIKE '%DATA_WRITE%' then 'On'
else 'Off'
end DATA_WRITE
from
gcp_audit_policy
where 
service = 'iam.googleapis.com' or
service = 'sts.googleapis.com'
),

creation as (
    select 
    UNNEST(array['iam.googleapis.com','sts.googleapis.com']) as service
    from 
    gcp_iam_policy
),

joining as (
select 
c.service as service,
case admin_read
when 'On' then 'On' else 'Off' 
end admin_read,
case data_write
when 'On' then 'On' else 'Off' 
end data_write,
case data_read
when 'On' then 'On' else 'Off' 
end data_read
from
result as r
right join creation as c on r.service = c.service
),

pivot as (
select
j.service as service,
UNNEST(array['ADMIN_READ','DATA_READ','DATA_WRITE']) as type,
UNNEST(array[j.ADMIN_READ,j.DATA_READ,j.DATA_WRITE]) as stat

from joining as j 
)

select 
row_number() over (order by p.service) as resource,
case p.service
when 'iam.googleapis.com' then 'Identity and Access Management (IAM) API' else 'Security Token Service API'
end service,
p.type,
p.stat,
case p.stat
when 'On' then 'ok' else 'alarm' 
end status,
case p.stat
when 'On' then 'Audit log is turned on' else 'Audit log should be turned on'
end reason
from pivot as p

  EOT
}
