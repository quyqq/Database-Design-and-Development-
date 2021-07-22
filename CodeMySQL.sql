drop table customer;
create table CUSTOMER
(
CustomerID bigint primary key auto_increment ,
CustomerName varchar(50) not null,
Street varchar(100) not null,
Address varchar(100) not null,
City varchar(100) not null,
PostCode integer not null,
CustomerContactNum varchar(20) not null
);
drop table AC_Unit;
create table AC_UNIT
(
AirID bigint primary key auto_increment, 
Make varchar(50) not null, 
Model varchar(50) not null, 
HP float not null
);
drop table JOB_REQUEST;
create table JOB_REQUEST
(
JobID bigint primary key auto_increment,
JobRequestDate datetime not null,
DateScheduled datetime not null,
JobStartDate datetime not null,
JobEndDate datetime not null,
JobType varchar(20) not null,
TotalCharges float not null,
CustomerID bigint,
constraint FK_JobRequest_Customer foreign key(CustomerID) references customer(CustomerID)
);

create table EMPLOYEE
(
EmployeeID bigint primary key auto_increment,
EmployeeName varchar(50) not null,
EmployeeStartDate datetime not null
);

create table EMP_JOB
(
EmployeeID bigint not null,
JobID bigint not null,
EmpStartDate datetime not null,
EmpFinishDate datetime null,
primary key (EmployeeID,JobID),
constraint FK_EmpJob_JobRequest foreign key (JobID) references JOB_REQUEST(JobID),
constraint FK_EmpJob_Employee foreign key(EmployeeID) references EMPLOYEE(EmployeeID)
);

create table  INVOICE
(
InvoiceID bigint primary key auto_increment,
InvoiceDate datetime not null,
InvoiceAmount float not null,
JobID bigint not null,
constraint FK_Invoice_JobRequest foreign key(JobID) references  JOB_REQUEST(JobID)
);

create table PAYMENT
(
PaymnetID bigint primary key auto_increment,
PaymentDate datetime not null,
PaidAmount decimal not null,
InvoiceID bigint not null,
constraint FK_Payment_Invoice foreign key (InvoiceID) references INVOICE(InvoiceID)
);

create table INSTALLATION
(
JobID bigint primary key,
HP float null,
Adress varchar(100) null,
InstallationType varchar(50) not null,
AirID bigint null,
constraint FK_Installation_JobRequest foreign key (JobID) references JOB_REQUEST(JobID),
constraint FK_Installation_ACUnit foreign key(AirID) references AC_UNIT(AirID)
);

create table REPAIR
(
JobID bigint primary key,
Problem text not null,
constraint FK_Repair_JobRequest foreign key (JobID) references JOB_REQUEST(JobID),
constraint FK_Repair_Installation foreign key(JobID) references INSTALLATION(JObID)
);

create table WALL_WINDOW_MOUNTED
(
JobID bigint primary key,
Location varchar(100) not null,
constraint FK_WallWindowMounted_Installation foreign key(JobID) references INSTALLATION(JObID)
);

create table DUCTED
(
JobID bigint primary key,
constraint FK_Ducted_Installation foreign key(JobID) references INSTALLATION(JObID)
);

create table ZONE
(
ZoneName varchar(50) primary key,
NumberOfOutlets integer not null,
JobID bigint not null,
constraint FK_Zone_Ducted foreign key(JobID) references DUCTED(JObID)

);