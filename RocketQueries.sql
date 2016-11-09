#Query utilizing join between 3+ tables:
#Returns payloads, and the vehicle model they were launched with
select pay_name, mod_name
from payload p
left join vehicle v on p.vehicle_id = v.vehicle_id
left join vehicle_model vm on v.vehicle_model_id = vm.vehicle_model_id;

#Query utilizing a join, group by, having, and an aggregate function:
#Returns launch vehicle, and the number of payloads on it, if it has more than one
select veh_name as vehicle_name, count(*) as number_of_payloads
from payload p
left join vehicle v on p.vehicle_id = v.vehicle_id
group by v.vehicle_id
having count(*) > 1;

#Query using a UNION:
#Returns Organizations that work with either payloads or launch vehicles
select org_name as organization
from vehicle v
left join organization o on o.organization_id = v.organization_id
union
select org_name
from payload p
left join organization o on o.organization_id = p.organization_id;

#Query using DISTINCT:
#Lists Organizations that have vehicles
select distinct org_name as organization
from vehicle v
left join organization o on o.organization_id = v.organization_id;

#Non-trivial data record modification other than INSERT VALUES (like UPDATE, or INSERT using SELECT)
#Travels back in time to destroy all of spacex's rockets on their successful flight
update launch_attempt la
left join vehicle v on v.vehicle_id = la.vehicle_id
set success_status = 'failure'
where success_status = 'success' and organization_id = 3;

select * from launch_attempt;

#Non-trivial VIEW
#has every launch attempt's time and success status, as well as the model of rocket, rocket name, and the name of the launch pad
create or replace view LaunchAttemptView as
select veh_name, mod_name, pad_name, launch_time, success_status
from launch_attempt la
left join launch_pad lp on lp.launch_pad_id = la.launch_pad_id
left join vehicle v on v.vehicle_id = la.vehicle_id
left join vehicle_model vm on vm.vehicle_model_id = v.vehicle_model_id
order by launch_time; 

select * from LaunchAttemptView;

#A function
#given a company id, returns the failure rate (failure/failure+success)
drop function if exists mission_failure_rate;
delimiter //
create function mission_failure_rate(_organization_id int) returns decimal(4,3)
begin
declare failure_rate decimal(4,3);
select sum(case when success_status = 'failure' then 1 else 0 end)/count(*) into failure_rate
from launch_attempt la
left join vehicle v on v.vehicle_id = la.vehicle_id
where organization_id = _organization_id and (success_status = 'success' or success_status = 'failure');
return failure_rate;
end
// delimiter ;

select mission_failure_rate(organization_id)
from organization;

#A procedure
#returns info on launch attempts by a given organization
drop procedure if exists get_organization_launches;
delimiter //
create procedure get_organization_launches(_organization_id int) 
begin
select veh_name, mod_name, pad_name, launch_time, success_status
from launch_attempt la
left join launch_pad lp on lp.launch_pad_id = la.launch_pad_id
left join vehicle v on v.vehicle_id = la.vehicle_id
left join vehicle_model vm on vm.vehicle_model_id = v.vehicle_model_id
where v.organization_id = _organization_id;
end
// delimiter ;

call get_organization_launches(6);
call get_organization_launches(3);
