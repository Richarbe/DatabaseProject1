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

create or replace view launch_attempt_full as
select launch_attempt_id, date_format(launch_time,'%Y-%m-%d %H:%i:%s') as launch_time, success_status, la.launch_pad_id, la.vehicle_id , veh_name, pad_name
from launch_attempt la
left join vehicle v on v.vehicle_id = la.vehicle_id
left join launch_pad lp on lp.launch_pad_id = la.launch_pad_id;

select * from launch_attempt_full;

create or replace view payload_full as
select p.*, veh_name, org_name
from payload p
left join vehicle v on v.vehicle_id = p.vehicle_id
left join organization o on o.organization_id = p.organization_id;

select * from payload_full;

drop function if exists vehicle_failure_rate;
delimiter //
create function vehicle_failure_rate(_vehicle_model_id int) returns decimal(4,3)
begin
declare failure_rate decimal(4,3);
select sum(case when success_status = 'failure' then 1 else 0 end)/count(*) into failure_rate
from launch_attempt la
left join vehicle v on v.vehicle_id = la.vehicle_id
where vehicle_model_id = _vehicle_model_id and (success_status = 'success' or success_status = 'failure');
return failure_rate;
end
// delimiter ;

select *, vehicle_failure_rate(vehicle_model_id) as fail_rate
from vehicle_model;