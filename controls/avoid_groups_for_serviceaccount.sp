control "Avoid_using_groups_for_serice_account_member" {
  title = "Avoid using groups for granting service accounts access to resources"
  description = "check"
  sql = <<EOT
with member as(
select
s.name as name,
s.display_name as display_name,
jsonb_array_elements_text(b -> 'members') as members

from
gcp_service_account as s,
jsonb_array_elements(iam_policy -> 'bindings') as b
)

select 
m.name as resource,
m.display_name ,
split_part(m.members,':',2),
case
when split_part(m.members,':',1) ='group' then 'alarm'
else 'ok'
end status,
case
when split_part(m.members,':',1) ='group' then 'Avoid using groups for granting service accounts access to resources'
else 'Not a group user'
end reason

from
member as m

order by m.display_name
EOT
}

