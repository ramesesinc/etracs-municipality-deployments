[clean-all]
update vehicle_application SET taskid = NULL;
update vehicle_account SET supersederid = NULL;
update vehicle_franchise SET appid = NULL,unitid=NULL,acctid=null,permitid=null;
update vehicle_application SET unitid=NULL,acctid=null;
delete from vehicle_payment_item;
delete from vehicle_payment;	
delete from vehicle_application_fee;	
delete from vehicle_permit;
delete from vehicle_application_task;
delete from vehicle_account;
delete from vehicle_unit_info;
delete from vehicle_unit;
delete from vehicle_application_info;	
delete from vehicle_application;

DELETE FROM vehicle_driver_franchise;
DELETE FROM vehicle_driver;