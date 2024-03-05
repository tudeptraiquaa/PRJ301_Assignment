create table Major(
id nvarchar(5) primary key,
[name] nvarchar(150)
)

create table [Subject](
id nvarchar(10) primary key,
[name] nvarchar(150),
creadit int,
semester int,
prerequisites nvarchar(10) foreign key references [Subject](id),
majorId nvarchar(5) foreign key references Major(id)
)

create table Assessment(
id nvarchar(5) primary key,
[name] nvarchar(50)
)

create table Grade(
assessmentId nvarchar(5) foreign key references Assessment(id),
subjectId nvarchar(10) foreign key references [Subject](id),
quantity int,
[weight] float
)

create table Room(
id nvarchar(10) primary key
)

create table Lecturer(
id nvarchar(50) primary key,
[name] nvarchar(150),
phoneNumber nvarchar(15),
qualification nvarchar(150)
)

create table Slot(
id nvarchar(5) primary key,
startTime nvarchar(5),
endTime nvarchar(5)
)

create table Term(
id nvarchar(5) primary key,
[name] nvarchar(10),
monthBegin int,
monthEnd int
)

create table Student(
id nvarchar(10) primary key,
[name] nvarchar(150),
gender bit,
dob date,
[address] nvarchar(150),
majorId nvarchar(5) foreign key references Major(id)
)

create table [Dependent](
studentId nvarchar(10) foreign key references Student(id),
[name] nvarchar(150),
gender bit,
dob date,
relationship nvarchar(150)
)

create table [Group](
id nvarchar(10) primary key
)

create table Schedule(
groupId nvarchar(10) foreign key references [Group](id),
roomId nvarchar(10) foreign key references Room(id),
subjectId nvarchar(10) foreign key references [Subject](id),
slotId nvarchar(5) foreign key references Slot(id),
[weekday] int,
termId nvarchar(5) foreign key references Term(id),
[year] int
)

create table Lession(
lecturerId nvarchar(50) foreign key references Lecturer(id),
groupId nvarchar(10) foreign key references [Group](id),
subjectId nvarchar(10) foreign key references Subject(id)
)

create table isTaken(
lecturerId nvarchar(50) foreign key references Lecturer(id),
groupId nvarchar(10) foreign key references [Group](id),
[status] bit,
[time] datetime
)

create table Attendance(
studentId nvarchar(10) foreign key references Student(id),
subjectId nvarchar(10) foreign key references Subject(id),
groupId nvarchar(10) foreign key references [Group](id),
isPresent bit,
record datetime,
[description] nvarchar(500)
)

create table Participate(
studentId nvarchar(10) foreign key references Student(id),
subjectId nvarchar(10) foreign key references Subject(id),
groupId nvarchar(10) foreign key references [Group](id)
)

create table Score(
studentId nvarchar(10) foreign key references Student(id),
assessmentId nvarchar(5) foreign key references Assessment(id),
subjectId nvarchar(10) foreign key references [Subject](id),
[value] float
)

create table Holiday(
[from] date,
[to] date
)

insert into Holiday([from], [to]) values ('2024-02-05','2024-02-16')

insert into Major (id, name) values ('SE', 'Software Engineering')

insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('GDQP', 'Military training', 3, 0, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('VOV124', 'Vovinam 2', 3, 0, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('VOV134', 'Vovinam 3', 3, 0, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('VOV114', 'Vovinam 1', 3, 0, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('TRS601', 'Transition', 3, 0, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('TMI101', 'Tradutional musical instrument', 3, 0, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SSL101c', 'Academic Skills for University Success', 3, 1, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('CSI104', 'Introduction to Computer Science', 3, 1, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('PRF192', 'Programming Fundamentals', 3, 1, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('MAE101', 'Mathematics for Engineering', 3, 4, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('CEA201', 'Conputer organization and Architecture', 3, 1, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('PRO192', 'Object-Oriented Programming', 3, 2, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('MAD101', 'Discrete mathematics', 3, 2, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('NWC203c', 'Computer Networking', 3, 2, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SSG104', 'Communication and In-Group Working Skills', 3, 2, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('JPD113', 'Elementary Japanese 1-A1.1', 3, 3, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('CSD201', 'Data Structures and Algorithms', 3, 3, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('DBI202', 'Introduction to Databases', 3, 3, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('LAB211', 'OOP with Java Lab', 3, 3, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('WED201c', 'Web Design', 3, 3, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SWE201c', 'Introduction to Software Engineering', 3, 4, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SWP391', 'Application development project', 3, 5, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('ITE302c', 'Ethics in IT', 3, 5, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('ACC101', 'Principles of Accounting', 3, 5, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SWR302', 'Software Requirement', 3, 5, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SWT301', 'Software Testing', 3, 5, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('OJT202', 'On the hob traning', 3, 6, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('ENW492c', 'Writing Research Papers', 3, 6, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SE-0003', 'Elective 3', 3, 7, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('PRM392', 'Mobile Programming', 3, 7, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SWD392', 'SW Architecture and Design', 3, 7, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('EXE101', 'Experiential Entrepreneurship 1', 3, 7, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SE-0002', 'Elective 2', 3, 7, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SE-0004', 'Elective 4', 3, 8, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('MLN122', 'Political economics of Marxism - Leninism', 3, 8, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('MLN111', 'Philosophy of Marxism - Leninism', 3, 8, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('EXE201', 'Experiential Entrepreneurship 2', 3, 8, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('PMG202c', 'Project management', 3, 8, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('WDU203c', 'UI/UX Design', 3, 8, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('MLN131', 'Scientific socialism', 3, 9, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('VNR202', 'History of Viet Nam Communist Party', 3, 9, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('SEP490', 'SE Capstone Project', 3, 9, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('HCM202', 'Ho Chi Minh Ideology', 3, 9, null, 'SE')

insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('MAS291', 'Statistics and Probability', 3, 4, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('JPD123', 'Elementary Japanese 1-A1.2', 3, 4, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('PRJ301', 'Java Web Application Development', 3, 4, null, 'SE')
insert into [Subject] (id, name, creadit, semester, prerequisites, majorId) values ('IOT102', 'Internet of Things', 3, 4, null, 'SE')

insert into Assessment (id, name) values ('Asm', 'Assignment')
insert into Assessment (id, name) values ('Pt', 'Progress test')
insert into Assessment (id, name) values ('PE', 'Practical Exam')
insert into Assessment (id, name) values ('FE', 'Final Exam')
insert into Assessment (id, name) values ('FE-L', 'FE: Listening')
insert into Assessment (id, name) values ('FE-GVR', 'FE: GVR')
insert into Assessment (id, name) values ('FE-L-R', 'FE: Listening Resit')
insert into Assessment (id, name) values ('FE-GVR-R', 'FE: GVR Resit')
insert into Assessment (id, name) values ('FER', 'Final Exam Resit')
insert into Assessment (id, name) values ('Ws', 'Workshop')
insert into Assessment (id, name) values ('Exc', 'Exercises')
insert into Assessment (id, name) values ('Pre', 'Presentation')
insert into Assessment (id, name) values ('Lab', 'Lab')
insert into Assessment (id, name) values ('Par', 'Participation')
insert into Assessment (id, name) values ('Mid', 'Mid-term test')
insert into Assessment (id, name) values ('CP', 'Computer Project')
insert into Assessment (id, name) values ('Par', 'Participation')
insert into Assessment (id, name) values ('Atl', 'Active learning')
insert into Assessment (id, name) values ('Prj', 'Project')



insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAE101', 'Asm', 3, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAE101', 'Pt', 3, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAE101', 'FE', 1, 0.4)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAE101', 'FER', 1, 0.4)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAD101', 'Asm', 3, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAD101', 'Pt', 3, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAD101', 'FE', 1, 0.4)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAD101', 'FER', 1, 0.4)

insert into Grade (subjectId, assessmentId, quantity, weight) values ('PRJ301', 'Pt', 2, 0.05)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('PRJ301', 'Ws', 2, 0.05)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('PRJ301', 'PE', 1, 0.2)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('PRJ301', 'Asm', 1, 0.4)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('PRJ301', 'FE', 1, 0.2)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('PRJ301', 'FER', 1, 0.2)

insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAS291', 'CP', 1, 0.15)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAS291', 'Asm', 2, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAS291', 'PT', 3, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAS291', 'FE', 1, 0.35)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('MAS291', 'FER', 1, 0.35)

insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD123', 'Par', 1, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD123', 'Pt', 2, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD123', 'Mid', 1, 0.3)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD123', 'FE-L', 1, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD123', 'FE-GVR', 1, 0.3)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD123', 'FE-L-R', 1, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD123', 'FE-GVR-R', 1, 0.3)

insert into Grade (subjectId, assessmentId, quantity, weight) values ('CSD201', 'Asm', 2, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('CSD201', 'Pt', 2, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('CSD201', 'PE', 1, 0.3)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('CSD201', 'FE', 1, 0.3)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('CSD201', 'FER', 1, 0.3)

insert into Grade (subjectId, assessmentId, quantity, weight) values ('DBI202', 'Lab', 5, 0.02)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('DBI202', 'Pt', 2, 0.05)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('DBI202', 'Asm', 1, 0.2)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('DBI202', 'PE', 1, 0.3)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('DBI202', 'FE', 1, 0.3)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('DBI202', 'FER', 1, 0.3)

insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD113', 'Par', 1, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD113', 'Pt', 2, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD113', 'mid', 1, 0.3)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD113', 'FE-L', 1, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD113', 'FE-GVR', 1, 0.3)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD113', 'FE-L-R', 1, 0.1)
insert into Grade (subjectId, assessmentId, quantity, weight) values ('JPD113', 'FE-GVR-R', 1, 0.3)

insert into Grade (subjectId, assessmentId, quantity, weight, groupId) values ('IOT102', '', 1, 0.3, 'SE1817')


select * from Assessment

insert into Room (id) values ('BE-101')
insert into Room (id) values ('BE-102')
insert into Room (id) values ('BE-103')
insert into Room (id) values ('BE-104')
insert into Room (id) values ('BE-105')
insert into Room (id) values ('BE-106')
insert into Room (id) values ('BE-107')
insert into Room (id) values ('BE-108')
insert into Room (id) values ('BE-109')
insert into Room (id) values ('BE-110')
insert into Room (id) values ('BE-207')
insert into Room (id) values ('AL-R205')
insert into Room (id) values ('DE-215')
insert into Room (id) values ('DE-216')

insert into Room (id) values ('BE-301')
insert into Room (id) values ('BE-315')
insert into Room (id) values ('DE-217')
insert into Room (id) values ('DE-222')
insert into Room (id) values ('DE-331')
insert into Room (id) values ('BE-315')

insert into Lecturer (id, name, phoneNumber, qualification) values ('DonNT3', 'Nguyễn Thành Đôn', '0123456789', 'professor')
insert into Lecturer (id, name, phoneNumber, qualification) values ('TruongLX6', 'Lương Xuân Trường', '0223456789', 'professor')
insert into Lecturer (id, name, phoneNumber, qualification) values ('DungVT41', 'Vũ Thành Dũng', '0223236789', 'professor')
insert into Lecturer (id, name, phoneNumber, qualification) values ('AnhNN59', 'Nguyễn Ngọc Anh', '0523456789', 'professor')
insert into Lecturer (id, name, phoneNumber, qualification) values ('YenNTH126', 'Nguyễn Thị Hải Yến', '0323456789', 'professor')
insert into Lecturer (id, name, phoneNumber, qualification) values ('SonNT5', 'Ngô Thành Sơn', '0328456789', 'professor')
insert into Lecturer (id, name) values ('AnhNV6', 'Nguyen Viet Anh')
insert into Lecturer (id, name) values ('LongNV78', 'Nguyen Van Long')
insert into Lecturer (id, name) values ('SonNX', 'Hong Xuan Son')
insert into Lecturer (id, name) values ('AnhTTV20', 'Trinh Thi Van Anh')

insert into Lecturer (id, name) values ('OanhNT75', 'Nguyen Thi Oanh')
insert into Lecturer (id, name) values ('QuanTL3', 'Tran Lam Quan')
insert into Lecturer (id, name) values ('TuanVM2', 'Vuong Minh Tuan')
insert into Lecturer (id, name) values ('DungLTK', 'Le Thi Kim Dung')

insert into Slot (id, startTime, endTime) values ('Slot1', '7:30', '9:50')
insert into Slot (id, startTime, endTime) values ('Slot2', '10:00', '12:20')
insert into Slot (id, startTime, endTime) values ('Slot3', '12:50', '15:10')
insert into Slot (id, startTime, endTime) values ('Slot4', '15:20', '17:40')

insert into Term (id, [name], monthBegin, monthEnd) values ('SP', 'Spring', 1, 4)
insert into Term (id, [name], monthBegin, monthEnd) values ('SU', 'Summer', 5, 8)
insert into Term (id, [name], monthBegin, monthEnd) values ('FA', 'Fall', 9, 12)

insert into Student (id, [name], dob, gender, [address], majorId) values ('HE172387', 'Bùi Minh Tú', '2003-11-12', 1, 'Nam Định', 'SE')
insert into Student (id, [name]) values ('HE153228','Le Do Viet Hai')
insert into Student (id, [name]) values ('HE160232','Ha Thi Hai Yen')
insert into Student (id, [name]) values ('HE170052','Nguyen Thanh Dat')
insert into Student (id, [name]) values ('HE170064','Dinh Gia Han')
insert into Student (id, [name]) values ('HE170155','Pham Duy Kien')
insert into Student (id, [name]) values ('HE170322','Vu Van Phat')
insert into Student (id, [name]) values ('HE170386','Nguyen Khac Tung')
insert into Student (id, [name]) values ('HE170482','Tran Cong Hieu')
insert into Student (id, [name]) values ('HE170492','Nguyen Van Hai')
insert into Student (id, [name]) values ('HE170636','Nguyen Anh Tien')
insert into Student (id, [name]) values ('HE171272','Pham Quoc Nguyen')
insert into Student (id, [name]) values ('HE171507','Phan Dinh Tuan')
insert into Student (id, [name]) values ('HE171779','Nguyen Phuong Trang')
insert into Student (id, [name]) values ('HE171807','Le Quang Huy')
insert into Student (id, [name]) values ('HE170292','Nguyen Huy Hoang')


insert into Student (id, [name]) values ('HE170076','Dao Quy Hung')
insert into Student (id, [name]) values ('HE170091','Mac Tuan Son')
insert into Student (id, [name]) values ('HE170240','Trinh Van Quan')
insert into Student (id, [name]) values ('HE170775','Do Quang Huy')
insert into Student (id, [name]) values ('HE171010','Khuong Hong Thanh')
insert into Student (id, [name]) values ('HE171542','Tran Thanh Binh')
insert into Student (id, [name]) values ('HE172101','Phung Gia Khanh An')
insert into Student (id, [name]) values ('HE172416','Nguyen Thi Thuy')
insert into Student (id, [name]) values ('HE172532','Nguyen Thi Thu Hien')
insert into Student (id, [name]) values ('HE172578','Nguyen Quoc Trung')
insert into Student (id, [name]) values ('HE172632','Nguyen Phi Long')
insert into Student (id, [name]) values ('HE172637','Tran Ngoc Doanh')
insert into Student (id, [name]) values ('HE172706','Dinh Xuan Hieu')
insert into Student (id, [name]) values ('HE173121','Bui Duc Trong')
insert into Student (id, [name]) values ('HE173353','Hoang Huy Nhat')



insert into [Dependent] (studentId, [name], dob, gender, relationship) values ('HE172387', 'Bùi Văn Thuân', '1979-10-01', 1, 'Bố')
insert into [Dependent] (studentId, [name], dob, gender, relationship) values ('HE172387', 'Đinh Thị Hân', '1981-08-24', 0, 'Mẹ')
insert into [Dependent] (studentId, [name], dob, gender, relationship) values ('HE172387', 'Bùi Quốc Tuấn', '2001-10-01', 1, 'Anh')

insert into [Dependent] (studentId, [name], dob, gender, relationship) values ('HE170240', 'Trinh Van Uoc', '1976-03-12', 1, 'Parent')
insert into [Dependent] (studentId, [name], dob, gender, relationship) values ('HE170240', 'Nguyen Thi Hue', '1978-05-06', 1, 'Parent')
insert into [Dependent] (studentId, [name], dob, gender, relationship) values ('HE170240', 'Trinh Cong Minh', '1999-08-07', 1, 'Brother')
insert into [Dependent] (studentId, [name], dob, gender, relationship) values ('HE170240', 'Trinh Hong Ngoc', '2000-03-12', 0, 'Sister')

insert into [Group] (id) values ('SE1817')
insert into [Group] (id) values ('SE1821')

insert into [Group] (id) values ('IOT1702')
insert into [Group] (id) values ('AI1604')
insert into [Group] (id) values ('SE1610')
insert into [Group] (id) values ('SE1608')
insert into [Group] (id) values ('SE1501')
insert into [Group] (id) values ('SE1616')

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'CSD201', 'BE-105', 3, 'SP', 2023, 3)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'CSD201', 'BE-105', 4, 'SP', 2023, 5)
--
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('IOT1702', 'PRF192', 'BE-301', 1, 'SP', 2022, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('IOT1702', 'PRF192', 'BE-301', 1, 'SP', 2022, 4)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('IOT1702', 'PRF192', 'BE-301', 1, 'SP', 2022, 6)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('AI1604', 'DBI202', 'BE-315', 2, 'SP', 2022, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('AI1604', 'DBI202', 'BE-315', 2, 'SP', 2022, 4)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('AI1604', 'DBI202', 'BE-315', 2, 'SP', 2022, 6)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1610', 'PRJ301', 'DE-217', 3, 'SP', 2022, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1610', 'PRJ301', 'DE-217', 3, 'SP', 2022, 4)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1610', 'PRJ301', 'DE-217', 3, 'SP', 2022, 6)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1608', 'PRJ301', 'DE-222', 4, 'SP', 2022, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1608', 'PRJ301', 'DE-222', 4, 'SP', 2022, 4)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1608', 'PRJ301', 'DE-222', 4, 'SP', 2022, 6)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1501', 'IOT102', 'DE-331', 3, 'SP', 2022, 3)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1501', 'IOT102', 'DE-331', 3, 'SP', 2022, 5)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1616', 'MAS291', 'BE-101', 4, 'SP', 2022, 3)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1616', 'MAS291', 'BE-101', 4, 'SP', 2022, 5)
--
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'MAS291', 'BE-101', 'SLot3', 'SP', 2024, 3)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'MAS291', 'BE-101', 'SLot4', 'SP', 2024, 5)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'JPD123', 'BE-101', 'SLot4', 'SP', 2024, 3)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'JPD123', 'BE-101', 'SLot3', 'SP', 2024, 5)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'IOT102', 'BE-101', 'SLot3', 'SP', 2024, 4)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'IOT102', 'BE-101', 'SLot4', 'SP', 2024, 6)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'PRJ301', 'BE-101', 'SLot4', 'SP', 2024, 4)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'PRJ301', 'BE-101', 'SLot3', 'SP', 2024, 6)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'CSD201', 'DE-215', '1', 'FA', 2023, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'CSD201', 'DE-215', '2', 'FA', 2023, 5)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'DBI202', 'DE-216', '2', 'FA', 2023, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'DBI202', 'DE-216', '1', 'FA', 2023, 5)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'LAB211', 'AL-R205', '1', 'FA', 2023, 3)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'LAB211', 'AL-R205', '2', 'FA', 2023, 6)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'JPD113', 'DE-215', '1', 'FA', 2023, 6)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'JPD113', 'DE-215', '2', 'FA', 2023, 3)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'MAS291', 'BE-207', 'SLot1', 'SP', 2024, 4)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'MAS291', 'BE-207', 'SLot2', 'SP', 2024, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'JPD123', 'BE-207', 'SLot2', 'SP', 2024, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'JPD123', 'BE-207', 'SLot1', 'SP', 2024, 4)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'IOT102', 'BE-109', 'SLot1', 'SP', 2024, 3)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'IOT102', 'BE-109', 'SLot2', 'SP', 2024, 5)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'PRJ301', 'BE-207', 'SLot2', 'SP', 2024, 3)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'PRJ301', 'BE-207', 'SLot1', 'SP', 2024, 5)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'ACC101', 'BE-207', 2, 'SU', 2024, 2)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1821', 'EXE101', 'BE-207', 3, 'SU', 2024, 3)

insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'ACC101', 'BE-109', 4, 'SU', 2024, 5)
insert into Schedule (groupId, subjectId, roomId, slotId, termId, year, weekday) values ('SE1817', 'PRM392', 'BE-109', 2, 'SU', 2024, 2)

select * from Term


insert into Lession (groupId, lecturerId, subjectId) values ('SE1821', 'DonNT3', 'ACC101')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1821', 'TuanVM2', 'EXE101')

insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'SonNT5', 'ACC101')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'OanhNT75', 'PRM392')

insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'ACC101', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'PRM392', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170240', 'ACC101', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170240', 'EXE101', 'SE1821')

--
insert into Lession (groupId, lecturerId, subjectId) values ('IOT1702', 'SonNT5', 'PRF192')
insert into Lession (groupId, lecturerId, subjectId) values ('AI1604', 'SonNT5', 'DBI202')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1610', 'SonNT5', 'PRJ301')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1608', 'SonNT5', 'PRJ301')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1501', 'SonNT5', 'IOT102')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1616', 'SonNT5', 'MAS291')
--

insert into Lession (groupId, lecturerId, subjectId) values ('SE1821', 'SonNT5', 'CSD201')

insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'DungVT41', 'MAS291')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'AnhNN59', 'JPD123')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'SonNT5', 'PRJ301')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'YenNTH126', 'IOT102')

insert into Lession (groupId, lecturerId, subjectId) values ('SE1821', 'AnhNV6', 'MAS291')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1821', 'LongNV78', 'JPD123')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1821', 'SonNX', 'IOT102')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1821', 'AnhTTV20', 'PRJ301')

insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'OanhNT75', 'CSD201')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'QuanTL3', 'DBI202')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'TuanVM2', 'LAB211')
insert into Lession (groupId, lecturerId, subjectId) values ('SE1817', 'DungLTK', 'JPD113')

update Lession set numLession = 20 where subjectId != 'IOT102'

create table Account(
[user] nvarchar(50) primary key,
[password] nvarchar(10),
[role] int
)

insert into Account ([user], [password], [role]) values ('HE172387', '123', 1)
insert into Account ([user], [password], [role]) values ('SonNT5', '123', 2)
insert into Account ([user], [password], [role]) values ('admin', '123', 3)

insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'JPD123', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'CSD201', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'JPD113', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'DBI202', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172387', 'LAB211', 'SE1817')


insert into Participate (studentId, subjectId, groupId) values ('HE153228', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE153228', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE153228', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE153228', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE160232', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE160232', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE160232', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE160232', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170052', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170052', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170052', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170052', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170064', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170064', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170064', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170064', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170155', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170155', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170155', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170155', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170292', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170292', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170292', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170292', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170322', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170322', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170322', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170322', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170386', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170386', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170386', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170386', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170482', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170482', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170482', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170482', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170492', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170492', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170492', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170492', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170636', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170636', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170636', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170636', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE171272', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171272', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171272', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171272', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE171507', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171507', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171507', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171507', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE171779', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171779', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171779', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE171779', 'JPD123', 'SE1817')

----------
insert into Participate (studentId, subjectId, groupId) values ('HE170076', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170076', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170076', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170076', 'JPD123', 'SE1817')

insert into Participate (studentId, subjectId, groupId) values ('HE170091', 'MAS291', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE170091', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170091', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170091', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE170240', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170240', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170240', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170240', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE170775', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170775', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170775', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE170775', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE171010', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171010', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171010', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171010', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE171542', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171542', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171542', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171542', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE171807', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171807', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171807', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE171807', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE172101', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172101', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172101', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172101', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE172416', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172416', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172416', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172416', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE172532', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172532', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172532', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172532', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE172578', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172578', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172578', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172578', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE172632', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172632', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172632', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172632', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE172637', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172637', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172637', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172637', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE172706', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172706', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE172706', 'PRJ301', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE172706', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE173121', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE173121', 'IOT102', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE173121', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE173121', 'JPD123', 'SE1821')

insert into Participate (studentId, subjectId, groupId) values ('HE173353', 'MAS291', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE173353', 'IOT102', 'SE1817')
insert into Participate (studentId, subjectId, groupId) values ('HE173353', 'PRJ301', 'SE1821')
insert into Participate (studentId, subjectId, groupId) values ('HE173353', 'JPD123', 'SE1821')

insert into Score (studentId, subjectId, assessmentId, value) values ('HE172387', 'CSD201', 'Asm', '10')
insert into Score (studentId, subjectId, assessmentId, value) values ('HE172387', 'CSD201', 'Asm', '9')
insert into Score (studentId, subjectId, assessmentId, value) values ('HE172387', 'CSD201', 'Pt', '8')
insert into Score (studentId, subjectId, assessmentId, value) values ('HE172387', 'CSD201', 'Pt', '8.3')
insert into Score (studentId, subjectId, assessmentId, value) values ('HE172387', 'CSD201', 'PE', '9')
select s.slotId, s.weekday
from Participate p
join Schedule s on s.groupId = p.groupId and s.subjectId = p.subjectId
where p.studentId = 'HE172387'