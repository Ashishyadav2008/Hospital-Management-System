use ASHISH_DB
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
)
INSERT INTO Doctor (DoctorID, FirstName, LastName) VALUES
(1, 'Rajesh', 'Sharma'),
(2, 'Anita', 'Verma'),
(3, 'Suresh', 'Patil'),
(4, 'Neha', 'Singh'),
(5, 'Amit', 'Kumar'),
(6, 'Priya', 'Joshi'),
(7, 'Rohit', 'Gupta'),
(8, 'Meena', 'Yadav')
SELECT * FROM DOCTOR
CREATE TABLE Specialization (
    SpecializationID INT PRIMARY KEY,
    Description VARCHAR(100)  ,
    DoctorID INT  ,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
)
INSERT INTO Specialization (SpecializationID, Description, DoctorID) VALUES
(101, 'Cardiologist', 1),
(102, 'Dermatologist', 2),
(103, 'Orthopedic', 3),
(104, 'Neurologist', 4),
(105, 'Pediatrician', 5),
(106, 'Gynecologist', 6),
(107, 'ENT Specialist', 7),
(108, 'General Physician', 8)
SELECT * FROM Specialization
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50)  ,
    LastName VARCHAR(50)  ,
    InsuranceNumber VARCHAR(50) UNIQUE
)
INSERT INTO Patient (PatientID, FirstName, LastName, InsuranceNumber) VALUES
(201, 'Aarav', 'Shah', 'INS001'),
(202, 'Kavya', 'Mehta', 'INS002'),
(203, 'Rohan', 'Desai', 'INS003'),
(204, 'Ishita', 'Kapoor', 'INS004'),
(205, 'Manav', 'Reddy', 'INS005'),
(206, 'Simran', 'Chopra', 'INS006'),
(207, 'Arjun', 'Nair', 'INS007'),
(208, 'Tanvi', 'Bansal', 'INS008')
SELECT * FROM Patient
CREATE TABLE DoctorPatient (
    DoctorID INT  ,
    PatientID INT  ,
    PRIMARY KEY (DoctorID, PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
)


INSERT INTO DoctorPatient (DoctorID, PatientID) VALUES
(1, 201),
(8, 201),
(2, 202),
(3, 203),
(4, 204),
(8, 205),
(8, 206),
(8, 207),
(7, 208)
SELECT * FROM DoctorPatient

CREATE TABLE Diagnose (
    DiagnoseCode INT PRIMARY KEY,
    Details VARCHAR(200),
    PatientID INT  ,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
)
INSERT INTO Diagnose (DiagnoseCode, Details, PatientID) VALUES
(301, 'High Blood Pressure', 201),
(302, 'Skin Allergy', 202),
(303, 'Fracture in Arm', 203),
(304, 'Migraine', 204),
(305, 'Viral Fever', 205),
(306, 'Asthma', 206),
(307, 'Diabetes', 207),
(308, 'Ear Infection', 208),
(309, 'Flu & Cold', 201),
(310, 'Chickenpox', 202)
select * from Diagnose

select * from Doctor
SELECT * FROM Specialization
SELECT * FROM Patient
SELECT * FROM DoctorPatient
select * from Diagnose


SELECT 
    p.PatientID,
    p.FirstName + ' ' + p.LastName AS PatientName,
    d.DiagnoseCode,
    d.Details AS DiagnoseDetails,
    doc.DoctorID,
    doc.FirstName + ' ' + doc.LastName AS DoctorName,
    s.Description AS DoctorSpecialization,

    CASE 
        WHEN 
            (d.Details LIKE '%Blood Pressure%' AND s.Description IN ('Cardiologist', 'General Physician')) OR
            (d.Details LIKE '%Flu%' OR d.Details LIKE '%Cold%' AND s.Description = 'General Physician') OR
            (d.Details LIKE '%Allergy%' AND s.Description = 'Dermatologist') OR
            (d.Details LIKE '%Chickenpox%' AND s.Description IN ('Dermatologist','Pediatrician')) OR
            (d.Details LIKE '%Fracture%' AND s.Description = 'Orthopedic') OR
            (d.Details LIKE '%Migraine%' AND s.Description = 'Neurologist') OR
            (d.Details LIKE '%Viral Fever%' AND s.Description IN ('General Physician','Pediatrician')) OR
            (d.Details LIKE '%Asthma%' AND s.Description IN ('General Physician','Pediatrician')) OR
            (d.Details LIKE '%Diabetes%' AND s.Description = 'General Physician') OR
            (d.Details LIKE '%Ear Infection%' AND s.Description = 'ENT Specialist')
        THEN '✔️ Correct Doctor Assigned'
        ELSE '❌ Wrong Doctor Assigned'
    END AS ValidationResult

FROM Diagnose d
JOIN Patient p ON d.PatientID = p.PatientID
JOIN DoctorPatient dp ON p.PatientID = dp.PatientID
JOIN Doctor doc ON dp.DoctorID = doc.DoctorID
JOIN Specialization s ON doc.DoctorID = s.DoctorID
ORDER BY p.PatientID, d.DiagnoseCode



