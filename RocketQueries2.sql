use richardson;
#organization view
create or replace view organization_full as
select organization_id, org_name, date_format(start_date,'%Y-%m-%d') as start_date, date_format(end_date,'%Y-%m-%d') as end_date, o.location_id, loc_name, address
from organization o
left join location l on l.location_id = o.location_id;

drop view organizationfull;

select * from organization_full;