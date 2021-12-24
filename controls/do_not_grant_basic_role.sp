control "do_not_grant_basic_roles" {
  title = "Do not grant basic roles unless there is no alternative"
  sql = <<EOT
select 
 row_number() over (order by m) as resource,
 split_part(m, ':', 2) as user_name,
 split_part(b ->> 'role','/',2) as role,
 case
 when
 split_part(m, ':', 2) is null then 'ok'
 else 'alarm'
 end status,
 case
 when  b ->> 'role' = 'roles/owner' then 'Owner role should not be granted' 
 when  b ->> 'role' = 'roles/editor' then 'Editor role should not be granted' 
 when  b ->> 'role' = 'roles/viewer' then 'Viewer role should not be granted' 
 end reason
from
 gcp_iam_policy,
 jsonb_array_elements(bindings) as b,
 jsonb_array_elements_text(b -> 'members') as m
where
 b ->> 'role' = 'roles/owner' or
 b ->> 'role' = 'roles/editor' or
 b ->> 'role' = 'roles/viewer'

EOT
}
