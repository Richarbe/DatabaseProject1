use richardson;
drop table if exists payload;
drop table if exists vehicle;
drop table if exists launch_attempt;
drop table if exists vehicle_model;
drop table if exists launchpad;
drop table if exists organization;
drop table if exists location;

create table location(
	location_id int auto_increment primary key,
    loc_name varchar(127),
    address varchar(255) unique);
    
create table organization(
	organization_id int auto_increment primary key,
    org_name varchar(127),
    start_date date,
    end_date date);
    
create table launchpad(
	launchpad_id int auto_increment primary key,
    pad_name varchar(127),
    location_id int,
    organization_id int,
    foreign key (location_id) references location(location_id) on delete cascade,
    foreign key (organization_id) references organization(organization_id) on delete cascade);
    
create table vehicle_model(
	vehicle_model_id int auto_increment primary key,
    mod_name varchar(127),
    mass_at_pad_kg int,
    thrust_asl_kN int,
    use_status bool);
    
create table launch_attempt(
	launch_attempt_id int auto_increment primary key,
    launch_time date,
    success_status bool,
    launchpad_id int,
    foreign key (launchpad_id) references launchpad(launchpad_id) on delete cascade);
    
create table vehicle(
	vehicle_id int auto_increment primary key,
    veh_name varchar(63),
    vehicle_model_id int,
    launch_attempt_id int,
    organization_id int,
    foreign key (vehicle_model_id) references vehicle_model(vehicle_model_id) on delete cascade,
    foreign key (launch_attempt_id) references launch_attempt(launch_attempt_id) on delete cascade,
    foreign key (organization_id) references organization(organization_id) on delete cascade);
    
create table payload(
	payload_id int auto_increment primary key,
    pay_name varchar(127),
    destination varchar(127),
    success_status bool,
    vehicle_id int,
    organization_id int,
    foreign key (vehicle_id) references vehicle(vehicle_id) on delete cascade,
    foreign key (organization_id) references organization(organization_id) on delete cascade);
