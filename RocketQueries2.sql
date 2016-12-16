use richardson;
#organization view
create or replace view organization_full as
select organization_id, org_name, date_format(start_date,'%Y-%m-%d') as start_date, date_format(end_date,'%Y-%m-%d') as end_date, o.location_id, loc_name, address
from organization o
left join location l on l.location_id = o.location_id;

select * from organization_full;

#launch_pad view
create or replace view launch_pad_full as
select launch_pad_id, pad_name, lp.organization_id, org_name, lp.location_id, loc_name, address
from launch_pad lp
left join organization o on o.organization_id = lp.organization_id
left join location l on l.location_id = lp.location_id;

select * from launch_pad_full;

create or replace view vehicle_full as
select vehicle_id, veh_name, v.vehicle_model_id, mod_name, v.organization_id, org_name
from vehicle v
left join vehicle_model vm on vm.vehicle_model_id = v.vehicle_model_id
left join organization o on o.organization_id = v.organization_id;

select * from vehicle_full;