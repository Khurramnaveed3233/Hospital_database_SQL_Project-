create database hospital_database  

use hospital_database  

DROP TABLE IF EXISTS DOCTOR_PATIENT;
DROP TABLE IF EXISTS TESTS;
DROP TABLE IF EXISTS DIAGNOSIS;
DROP TABLE IF EXISTS MEDICATION_PRESCRIBED;
DROP TABLE IF EXISTS MEDICATION;
DROP TABLE IF EXISTS PATIENT;
DROP TABLE IF EXISTS BILL;
DROP TABLE IF EXISTS CAFETERIA_STAFF;
DROP TABLE IF EXISTS CAFETERIA;
DROP TABLE IF EXISTS STAFF;
DROP TABLE IF EXISTS DOCTOR;
DROP TABLE IF EXISTS WORKER;
DROP TABLE IF EXISTS DEPARTMENT;

CREATE TABLE DEPARTMENT (
    Department_ID        varchar(15) NOT NULL,
    Workers              INT,
    Building_Location    VARCHAR(15),
    CONSTRAINT Department_PK PRIMARY KEY (Department_ID)
);

CREATE TABLE WORKER (
    Worker_ID            INT NOT NULL,
    fname                VARCHAR(10),
    lname                VARCHAR(10),
    Gender               CHAR(1),
    telephone            VARCHAR(14),
    Salary               INT,
    CONSTRAINT Worker_PK PRIMARY KEY (Worker_ID)
);

CREATE TABLE DOCTOR (
    Doctor_ID            INT NOT NULL, 
    Field                VARCHAR(20),
    Degree               VARCHAR(30),
    Department_ID        varchar(15) NOT NULL,
    D_Worker_ID          INT NOT NULL,
    CONSTRAINT Doctor_PK PRIMARY KEY (Doctor_ID),
    CONSTRAINT Doctor_FK1 FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID),
    CONSTRAINT Doctor_FK2 FOREIGN KEY (D_Worker_ID) REFERENCES WORKER(Worker_ID)
);

CREATE TABLE STAFF (
    Staff_ID             INT NOT NULL, 
    Job_Title            VARCHAR(15),
    S_Worker_ID          INT,
    CONSTRAINT STAFF_PK PRIMARY KEY (Staff_ID),
    CONSTRAINT STAFF_FK1 FOREIGN KEY (S_Worker_ID) REFERENCES Worker (Worker_ID)
);

CREATE TABLE CAFETERIA (
    Cafeteria_ID         varchar(10) NOT NULL, 
    Food_Type            VARCHAR(15),
    Seating              SMALLINT,
    CONSTRAINT CAFETERIA_PK PRIMARY KEY (Cafeteria_ID)
);

CREATE TABLE CAFETERIA_STAFF (
    Staff_ID             INT NOT NULL,
    Cafeteria_ID        varchar(10) NOT NULL,
    Position             VARCHAR(15),
    CONSTRAINT CAFETERIA_STAFF_FK1 FOREIGN KEY (Staff_ID) REFERENCES STAFF (Staff_ID),
    CONSTRAINT CAFETERIA_STAFF_FK2 FOREIGN KEY (Cafeteria_ID) REFERENCES CAFETERIA (Cafeteria_ID)
);

CREATE TABLE BILL (
    Bill_ID              INT NOT NULL,
    Tests                VARCHAR(15),
    Treatment            VARCHAR(20),
    Time_Admitted        DATE,
    Prescription         VARCHAR(20),
    CONSTRAINT BILL_PK PRIMARY KEY (Bill_ID)
);

CREATE TABLE PATIENT (
    Patient_ID           INT NOT NULL,    
    fname                VARCHAR(10),
    lname                VARCHAR(10),
    Address              TEXT,
    telephone            VARCHAR(14),
    Gender               VARCHAR(5),
    Age                  INT,
    Blood_Type           VARCHAR(5),
    Cafeteria_ID        varchar(10) NOT NULL,
    Bill_ID              INT NOT NULL,
    CONSTRAINT PATIENT_PK PRIMARY KEY (Patient_ID),
    CONSTRAINT PATIENT_FK1 FOREIGN KEY (Cafeteria_ID) REFERENCES CAFETERIA(Cafeteria_ID),
    CONSTRAINT PATIENT_FK2 FOREIGN KEY (Bill_ID) REFERENCES BILL(Bill_ID)
);

CREATE TABLE MEDICATION (
    Medication_ID        varchar(15) NOT NULL,
    Doses                INT,
    Expiration_Date      DATE,
    CONSTRAINT MEDICATION_PK PRIMARY KEY (Medication_ID)
);

CREATE TABLE MEDICATION_PRESCRIBED (
    Prescription_ID      INT NOT NULL,
    Medication_ID        varchar(15) NOT NULL,
    Patient_ID           INT NOT NULL,
    CONSTRAINT MEDICATION_PERSCRIBED_PK PRIMARY KEY (Prescription_ID),
    CONSTRAINT MEDICATION_PERSCRIBED_FK1 FOREIGN KEY (Medication_ID) REFERENCES MEDICATION (Medication_ID),
    CONSTRAINT MEDICATION_PERSCRIBED_FK2 FOREIGN KEY (Patient_ID) REFERENCES PATIENT (Patient_ID)
);

CREATE TABLE DIAGNOSIS (
    Illness              VARCHAR(20) NOT NULL,
    Doctor_ID            INT NOT NULL,
    Patient_ID           INT NOT NULL,
    CONSTRAINT DIAGNOSIS_PK PRIMARY KEY (Illness),
    CONSTRAINT DIAGNOSIS_FK1 FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID),
    CONSTRAINT DIAGNOSIS_FK2 FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID)
);

CREATE TABLE TESTS (
    Test_ID              INT NOT NULL,
    Result               TINYINT,  -- Removed (1) as it's not needed
    Illness              VARCHAR(20),
    Doctor_ID            INT NOT NULL,
    Patient_ID           INT NOT NULL,
    CONSTRAINT TESTS_PK PRIMARY KEY (Test_ID),
    CONSTRAINT TESTS_FK1 FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID),
    CONSTRAINT TESTS_FK2 FOREIGN KEY (Illness) REFERENCES DIAGNOSIS(Illness),
    CONSTRAINT TESTS_FK3 FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID)
);

CREATE TABLE DOCTOR_PATIENT (
    Doctor_ID            INT NOT NULL,
    Patient_ID           INT NOT NULL,
    Time                 DATE,  -- Use DATE if only date is needed; use DATETIME or DATETIME2 for date and time
    CONSTRAINT DOCTOR_PATIENT_PK PRIMARY KEY (Doctor_ID, Patient_ID),
    CONSTRAINT DOCTOR_PATIENT_FK1 FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID),
    CONSTRAINT DOCTOR_PATIENT_FK2 FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID)
);

drop table DOCTOR_PATIENT

INSERT INTO DEPARTMENT VALUES ('ICU', '20', 'Dobson');
INSERT INTO DEPARTMENT VALUES ('Pediatric', '26', 'Wheeler');
INSERT INTO DEPARTMENT VALUES ('ER', '32', 'Dobson');
INSERT INTO DEPARTMENT VALUES ('Burn Center', '15', 'Campbell');
INSERT INTO DEPARTMENT VALUES ('Pharmacy', '8', 'Wheeler');

INSERT INTO WORKER VALUES (119275, 'Henry', 'Fuller', 'M', '(978)123-1234', 127000);
INSERT INTO WORKER VALUES (122842, 'Zack', 'Futa', 'M', '(123)436-1236', 122000);
INSERT INTO WORKER VALUES (197531, 'Cam', 'Ryder', 'M', '(543)753-1327', 72000);
INSERT INTO WORKER VALUES (128575, 'Janet', 'Grosmen', 'F', '(617)355-7684', 150000);
INSERT INTO WORKER VALUES (124865, 'Michelle', 'Haverhill', 'F', '(631)125-1235', 125000);
INSERT INTO WORKER VALUES (118467, 'Oliver', 'Mansman', 'M', '(934)126-6421', 49000);
INSERT INTO WORKER VALUES (195538, 'Lisa', 'Perez', 'F', '(682)165-8523', 64000);
INSERT INTO WORKER VALUES (123456, 'Tilda', 'White', 'F', '(723)983-8521', 100000);
INSERT INTO WORKER VALUES (124642, 'Patrick', 'McGuiyver', 'M', '(213)753-7234', 180000);
INSERT INTO WORKER VALUES (105293, 'Wilson', 'Wilson', 'M', '(734)357-9853', 52000);

INSERT INTO DOCTOR VALUES (12365, ' ', 'PHD', 'ICU', 124642);
INSERT INTO DOCTOR VALUES (15235, ' ', 'MD', 'Pediatric', 128575);
INSERT INTO DOCTOR VALUES (51235, ' ', 'PHD', 'ER', 123456);
INSERT INTO DOCTOR VALUES (67891, ' ', 'MD', 'Pharmacy', 119275);
INSERT INTO DOCTOR VALUES (14263, ' ', 'PHD', 'Burn Center', 124865);
INSERT INTO DOCTOR VALUES (15642, ' ', 'PHD', 'ER', 122842);

INSERT INTO STAFF VALUES (12, 'Cafeteria Staff', 197531);
INSERT INTO STAFF VALUES (1632, 'Janitor', 118467);
INSERT INTO STAFF VALUES (1834, 'Cafeteria Staff', 195538);
INSERT INTO STAFF VALUES (1462, 'Janitor', 105293);

INSERT INTO CAFETERIA VALUES ('Wheeler', 'Mash Potatoes', 150);
INSERT INTO CAFETERIA VALUES ('Dobson', 'Lunchables', 200);
INSERT INTO CAFETERIA VALUES ('Campbell', 'Mash Potatoes', 90);

INSERT INTO CAFETERIA_STAFF VALUES (12, 'Dobson', 'Cook');
INSERT INTO CAFETERIA_STAFF VALUES (1834, 'Campbell', 'Server');

INSERT INTO BILL VALUES (1423, 'MRI', 'Lumbar puncture', '2019-02-11','Null');
INSERT INTO BILL VALUES (1537, 'Blood test', 'Chemotherapy', '2019-02-09','Carboplatin');
INSERT INTO BILL VALUES (1632, 'Blood test', 'Null', '2019-02-16','Insulin');
INSERT INTO BILL VALUES (1744, 'EKG', 'Null', '2019-02-22 ', 'Thrombolytics');

INSERT INTO PATIENT VALUES (589215, 'Mike', 'Lock', '152 Main St', '(135)753-2346', 'M', 41, 'A+', 'Dobson', 1537);
INSERT INTO PATIENT VALUES (975913, 'Harry', 'Sax', '53 Chendogg Ave', '(643)764-1256', 'M', 21, 'O-', 'Campbell', 1632);
INSERT INTO PATIENT VALUES (193258, 'Jenny', 'Tayla', '651 Nowhre St', '(642)176-7421', 'F', 19, 'AB+', 'Dobson', 1423);
INSERT INTO PATIENT VALUES (497598, 'Benjamin', 'Dover', '63 Vancouver Way', '(432)753-1274', 'M', 72, 'B-', 'Wheeler', 1744);

INSERT INTO MEDICATION VALUES ('A104', 10, '2026-05-12');
INSERT INTO MEDICATION VALUES ('B205', 5, '2026-09-20');
INSERT INTO MEDICATION VALUES ('C312', 12, '2025-12-15');
INSERT INTO MEDICATION VALUES ('D918', 2, '2024-07-04');
INSERT INTO MEDICATION VALUES ('E501', 8, '2025-08-29');

INSERT INTO MEDICATION_PRESCRIBED VALUES (101, 'A104', 589215);
INSERT INTO MEDICATION_PRESCRIBED VALUES (102, 'B205', 975913);
INSERT INTO MEDICATION_PRESCRIBED VALUES (103, 'C312', 193258);
INSERT INTO MEDICATION_PRESCRIBED VALUES (104, 'D918', 497598);
INSERT INTO MEDICATION_PRESCRIBED VALUES (105, 'E501', 589215);

INSERT INTO DIAGNOSIS VALUES ('Flu', 12365, 589215);
INSERT INTO DIAGNOSIS VALUES ('Anemia', 15235, 975913);
INSERT INTO DIAGNOSIS VALUES ('Diabetes', 51235, 193258);
INSERT INTO DIAGNOSIS VALUES ('Pneumonia', 67891, 497598);
INSERT INTO DIAGNOSIS VALUES ('Hypertension', 14263, 589215);

INSERT INTO TESTS VALUES (135, 1, 'Flu', 12365, 589215);
INSERT INTO TESTS VALUES (246, 0, 'Anemia', 15235, 975913);
INSERT INTO TESTS VALUES (357, 1, 'Diabetes', 51235, 193258);
INSERT INTO TESTS VALUES (468, 1, 'Pneumonia', 67891, 497598);
INSERT INTO TESTS VALUES (579, 1, 'Hypertension', 14263, 589215);

INSERT INTO DOCTOR_PATIENT VALUES (12365, 589215, '2024-10-26');
INSERT INTO DOCTOR_PATIENT VALUES (15235, 975913, '2024-10-27');
INSERT INTO DOCTOR_PATIENT VALUES (51235, 193258, '2024-10-28');
INSERT INTO DOCTOR_PATIENT VALUES (67891, 497598, '2024-10-29');
INSERT INTO DOCTOR_PATIENT VALUES (14263, 589215, '2024-10-30');

select * from DOCTOR_PATIENT

=====================================================================================
select * from DIAGNOSIS
select * from Doctor
select * from worker
select * from MEDICATION_PRESCRIBED
SELECT * FROM PATIENT 
SELECT * FROM DEPARTMENT

--- Q1. find all doctors who have treated a patient of "diabetes"

select d.doctor_id , dg.illness , d.degree , d.department_id  
from doctor d
join diagnosis dg  on d.doctor_id = dg.doctor_id 
where illness = 'diabetes' 

--- Q2. list all the details of  patients who have been subscribed 'C312'

select * from patient p 
join  MEDICATION_PRESCRIBED ps on p.patient_id = ps.patient_id 
where medication_id = 'C312'


--- Q3. Retrieve all the names and phone numbers of all the patients who have been doagnosed 'Anemia'

select  p.fname , p.lname , p.telephone 
from patient p 
join diagnosis d on p.patient_id = d.patient_id 
where illness = 'Anemia'

---- Q4. Find the degree  and IDs of all the doctots who works in 'ER' department 

select do.doctor_id , do.degree
from doctor do 
join department d 
on do.department_id  = d.department_id 
where D.department_id = 'ER' 

--- Q5 . Find the total salary expenditure forall worker 

SELECT * FROM WORKER

select sum(salary) as total_salary_expenditure 
from worker 

--- Q6. List all cafeteria staff along with their job title and food type serve in their assigned cafeteria . 

select * from CAFETERIA_STAFF
select * from CAFETERIA
select * from staff

select cs.staff_id , s.job_title as job_title , c.food_type 
from  CAFETERIA_STAFF cs 
join staff s on cs.staff_id = s.staff_id 
join cafeteria c on cs.cafeteria_id = c.cafeteria_Id 

--- Q7. Show details of patient along with their medications they are perscribed even if no medication has been perscribed . 

select * from patient 
select * from MEDICATION_PRESCRIBED 
select * from MEDICATION
select * from diagnosis

select * 
from patient p 
left join MEDICATION_PRESCRIBED as mp
on p.patient_id = mp.patient_id 
left join medication m 
on mp.medication_id = m.medication_id 

--- Q8 . Find average age of patients daignosed by 'flu' 

select  avg(p.age) as Patients_Average_age 
from patient as p 
join diagnosis d on p.patient_id = d.patient_id 
where d.illness = 'flu' 

