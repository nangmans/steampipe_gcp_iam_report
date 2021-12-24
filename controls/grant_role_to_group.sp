control "Grant_roles_to_a_Google_group" {
  title = "Grant roles to a Google group instead of individual users when possible"
  sql = <<EOT
with member as(
select
RTRIM(split_part(jsonb_array_elements_text(e->'members'),':',2),'"') as member,
split_part(jsonb_array_elements_text(e->'members'),':',1) as type,
split_part(e->>'role','/',2) as role

from
gcp_iam_policy as p,
jsonb_array_elements(p.bindings) as e
)

select 
m.member,
m.type,
m.role as resource,
case
when type = 'group' then 'ok'
else 'info'
end status,
case
when type = 'group' then 'Granting roles to a Google group user'
else 'Granting roles to group user instead individual user'
end reason
from
member as m

where m.type != 'serviceAccount' and
m.type != 'deleted'
order by m.member
  EOT
}

