insert into location(loc_name, address)
	values	("Cape Canaveral Air Force Station", "Cape Canaveral, FL 32920"),
			("Spacex Headquarters", "1 Rocket Road, Hawthorne, CA 90250");

insert into organization(org_name, start_date, end_date, location_id)
	values	("United States Air Force", "1947-09-18", null, null),
			("National Aeronautics and Space Administration", "1958-07-29", null, null),
			("Space Exploration Technologies Corporation", "2002-06-00", null, 2),
            ("National Reconnaissance Office", "1961-09-06", null, null),
            ("United States Army", "1775-06-14", null, null),
            ("United Launch Alliance", "2006-12-01", null, null);
            
insert into launch_pad(pad_name, location_id, organization_id)
	values	("CCAFS SLC-40", 1, 1),
			("CCAFS SLC-41", 1, 1);

insert into vehicle_model(mod_name, mass_at_pad_kg, thrust_asl_kN, use_status)
	values	("falcon 9 v1.0", 333400, 4940, 'retired'),
			("falcon 9 v1.1", 505846, 5885, 'retired'),  
            ("falcon 9 FT", 549054, 6806, 'active'),
            ("Atlas V 401", 46697, 1688, 'active'),
            ("Atlas V 501", 46697, 1688, 'active');

insert into vehicle(veh_name, vehicle_model_id, organization_id)
	values	("F9-001", 1, 3),
			("F9-002", 1, 3),
            ("AV-021", 4, 6);

insert into launch_attempt(launch_time, success_status, launch_pad_id, vehicle_id)
	values	('2010-03-09 00:00:00', 'scrub', 1, 1),
			('2010-06-04 00:00:00', 'scrub', 1, 1),
            ('2010-06-04 18:45:00', 'success', 1, 1),
            ('2010-12-03 00:00:00', 'scrub', 1, 2),
            ('2010-12-04 00:00:00', 'scrub', 1, 2),
            ('2010-12-04 12:00:00', 'scrub', 1, 2),
            ('2010-12-05 00:00:00', 'scrub', 1, 2),
            ('2010-12-08 00:00:00', 'scrub', 1, 2),
            ('2010-12-08 15:43:00', 'success', 1, 2),
            ('2010-02-10 15:26:00', 'scrub', 2, 3),
            ('2010-02-11 15:23:00', 'success', 2, 3);

insert into payload(pay_name, destination, success_status, vehicle_id, organization_id)
	values	("Dragon Spacecraft Qualification Unit", "LEO", 'success', 1, 3),
			("NASA COTS - Demo 1", "LEO", 'success', 2, 2),
            ("QbX", "LEO", 'success', 2, 4),
            ("SMDC-ONE", "LEO", 'success', 2, 5),
            ("Solar Dynamics Observatory", "GEO", 'success', 3, 2);

/*    
select * from location;
select * from organization;
select * from launch_pad;
select * from vehicle_model;
select * from launch_attempt;
select * from vehicle;
select * from payload;
*/