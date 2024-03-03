
-- tìm list sinh viên của một group theo mon

select p.groupId, p.studentId, s.name as studentName
from Participate p
join Student s on p.studentId = s.id
where p.subjectId = 'PRJ301' and p.groupId = 'SE1817'
order by s.id

--thoi khoa bieu cua sinh vien
select distinct s.id, t.name as termName, t.monthBegin, t.monthEnd, sche.year, sub.id as subjectId, sub.name as subjectName, 
sche.weekday, Slot.id as slotId, Slot.startTime, Slot.endTime, sche.roomId,
le.numLession, lec.id as lecturerId
from Student s
join Participate p on s.id = p.studentId
join Schedule sche on sche.groupId = p.groupId and p.subjectId = sche.subjectId
join [Subject] sub on p.subjectId = sub.id
join Term t on Sche.termId = t.id
join Slot on sche.slotId = Slot.id
join Lession le on le.groupId = sche.groupId and le.subjectId = sche.subjectId
join Lecturer lec on lec.id = le.lecturerId
where s.id = 'HE172387'
order by sche.weekday, Slot.startTime

-- thoi khoa bieu cua giang vien
select distinct sche.groupId, sche.subjectId, sche.roomId, sche.weekday, 
t.monthBegin, t.monthEnd, sche.year, t.id as termId,
Slot.id as slotId, le.numLession
from Lecturer lec
join Lession le on lec.id = le.lecturerId
join Schedule sche on le.groupId = sche.groupId and le.subjectId = sche.subjectId
join Slot on sche.slotId = Slot.id
join Term t on sche.termId = t.id
where lec.id = 'SonNT5'

-- lay mon hoc da day
select distinct sche.subjectId, le.numLession, sche.year, t.id as termId,
le.groupId
from Lession le
join Schedule sche on le.groupId = sche.groupId and le.subjectId = sche.subjectId
join Term t on sche.termId = t.id
where le.lecturerId = 'SonNT5'

-- thoi khoa bieu mon hoc
select slotId, [weekday] from Schedule s
where groupId = 'SE1817' and subjectId = 'MAS291' 

-- so luong tiet hoc moi mon
select distinct le.lecturerId, le.groupId, le.subjectId, le.numLession, sche.termId, sche.year, sche.roomId
from Lession le
join Schedule sche on le.groupId = sche.groupId and le.subjectId = sche.subjectId

-- lay cac khoa hoc
select distinct a.subjectId from
(select g.subjectId, p.studentId, g.assessmentId, g.quantity, g.weight
from [Grade] g
join Participate p on g.subjectId = p.subjectId
where p.studentId = 'HE172387'
) a

-- lay cac khoa hoc theo ki
select distinct a.termId, a.name, a.year, a.monthBegin from
(select distinct p.subjectId, sche.termId, 
t.name, t.monthBegin, sche.year
from Participate p
join Schedule sche on p.groupId = sche.groupId and p.subjectId = sche.subjectId
join Term t on sche.termId = t.id
where p.studentId = 'HE172387') a
order by a.year, a.monthBegin

--lay subject student theo mon
select distinct p.subjectId, sub.name as subjectName
from Participate p
join Schedule s on p.groupId = s.groupId and p.subjectId = s.subjectId
join Subject sub on p.subjectId = sub.id
where p.studentId = 'HE172387' and s.termId='FA' and s.year=2023


-- lay Assessment theo mon
select g.assessmentId,
a.name as assessmentName, g.quantity, g.weight
from Grade g
join Assessment a on g.assessmentId = a.id
where g.subjectId = 'JPD123'

--lay diem 
select  g.assessmentId, s.value,
a.name as assessmentName, g.quantity, g.weight
from Grade g
join Assessment a on g.assessmentId = a.id
left join 
(
select s.studentId, s.subjectId, s.assessmentId, s.value from Score s
where s.studentId = 'HE172387' and s.termId = 'FA' and s.year = 2023
) s on s.assessmentId = g.assessmentId and s.subjectId = g.subjectId
where g.subjectId = 'JPD113'

select * from Score

-- mon hoc trong ki cua mot lop

select distinct s.groupId from Schedule s
join Term t on s.termId = t.id
where s.year = 2022 and t.monthBegin <= 2 and t.monthEnd >= 2

select distinct s.groupId from Schedule s
where s.termId = 'SP' and s.year = 2022
---
--Mon hoc cua mot lop theo ki
select distinct s.subjectId from Schedule s
where s.groupId = 'SE1817' and s.termId = 'SP' and s.year = 2024
--
select distinct p.studentId, p.subjectId, sche.roomId, l.groupId, sche.slotId, i.date, a.isPresent as [status]
from Participate p 
join Lession l on p.groupId = l.groupId and p.subjectId = l.subjectId
join isTaken i on i.lecturerId = l.lecturerId and i.groupId = l.groupId
join Schedule sche on sche.groupId = p.groupId and sche.subjectId = p.subjectId and i.slotId = sche.slotId
left join Attendance a on a.date = i.date and a.groupId = p.groupId and a.subjectId = p.subjectId and p.studentId = a.studentId
where p.studentId = 'HE172387'
and i.date >= '2024-01-01' and i.date <= '2024-02-01'
order by i.date, p.subjectId

-- nam hoc cua student

select distinct sche.year from Participate p
join Schedule sche on p.groupId = sche.groupId and sche.subjectId = p.subjectId
where p.studentId = 'HE172387'
order by sche.year

select * from Participate
where studentId = 'HE172387'

-- ngay bat dau mon hoc
select a.date as dateBegin, b.date as dateEnd from
(select top 1 l.groupId, l.subjectId, i.date from isTaken i
join Lession l on i.groupId = l.groupId and i.lecturerId = l.lecturerId
where l.subjectId = 'IOT102' and l.groupId = 'SE1817'
order by i.date) a
join
(select top 1 l.groupId, l.subjectId, i.date from isTaken i
join Lession l on i.groupId = l.groupId and i.lecturerId = l.lecturerId
where l.subjectId = 'IOT102' and l.groupId = 'SE1817'
order by i.date desc) b
on a.groupId = b.groupId and a.subjectId = b.subjectId

--- set diem danh
update Attendance set isPresent = ?, [description] = ?, timeRecord = ?
where studentId = ? and subjectId = ? and [date] = ?

--check is taken

select * from isTaken
update isTaken set changeLecturer = 'SonNT5' where lecturerId = 'AnhNN59' and date='2024-01-02'
select * from Attendance
update isTaken set status = null, timeRecord = null

delete from Attendance

 select * from Attendance

 --get attendance student by subject

select p.studentId, sche.[weekday], i.[date], i.slotId, s.startTime, s.endTime, 
sche.roomId, l.lecturerId, p.groupId, a.isPresent, a.[description]
from Participate p
join Lession l on p.groupId = l.groupId and p.subjectId = l.subjectId
join isTaken i on i.groupId = l.groupId and i.lecturerId = l.lecturerId
join Schedule sche on sche.groupId = p.groupId and sche.subjectId = p.subjectId and sche.slotId = i.slotId
join Slot s on s.id = i.slotId
left join Attendance a on a.studentId = p.studentId and a.groupId = p.groupId
and a.subjectId = p.subjectId and a.slotId = i.slotId and a.[date] = i.[date]
where p.studentId = 'HE172387' and p.subjectId = 'IOT102' and sche.termId = 'SP' and sche.year = 2024


--lich day cua giao vien trong 1 ngay

select distinct i.lecturerId, i.groupId, l.subjectId, i.slotId, i.date, i.changeLecturer
from isTaken i
join Lession l on l.groupId = i.groupId and l.lecturerId = i.lecturerId
join Schedule sche on sche.groupId = i.groupId and sche.subjectId = l.subjectId and i.slotId = sche.slotId
where ((i.lecturerId = 'SonNT5' and i.changeLecturer is null) or i.changeLecturer = 'SonNT5')
and date = '2024-03-01'
order by i.slotId

select distinct i.lecturerId, i.groupId, l.subjectId, i.slotId, i.date, i.changeLecturer
from isTaken i
join Lession l on l.groupId = i.groupId and l.lecturerId = i.lecturerId
join Schedule sche on sche.groupId = i.groupId and sche.subjectId = l.subjectId and i.slotId = sche.slotId
where ((i.lecturerId = 'AnhNN59' and i.changeLecturer is null) or i.changeLecturer = 'AnhNN59')
and date = '2024-03-01'
order by i.slotId

delete from Attendance where date = '2024-02-21'

select * from Attendance where date = '2024-02-21'

Update isTaken set status = null where date = '2024-02-21'

--
select p.studentId, sche.[weekday], i.[date], i.slotId, s.startTime, s.endTime, 
sche.roomId, l.lecturerId, p.groupId, a.isPresent, a.[description], i.status as isTakenGroup
from Participate p
join Lession l on p.groupId = l.groupId and p.subjectId = l.subjectId
join isTaken i on i.groupId = l.groupId and i.lecturerId = l.lecturerId
join Schedule sche on sche.groupId = p.groupId and sche.subjectId = p.subjectId and sche.slotId = i.slotId
join Slot s on s.id = i.slotId
left join Attendance a on a.studentId = p.studentId and a.groupId = p.groupId
and a.subjectId = p.subjectId and a.slotId = i.slotId and a.[date] = i.[date]
where p.studentId = 'HE172387' and p.subjectId = 'PRJ301' and sche.termId = 'SP' and sche.year = 2024
order by i.date

-------------Taken group
select distinct l.lecturerId, i.slotId, sche.subjectId, s.name, sche.groupId, sche.roomId, i.status, i.[date]
from isTaken i
join Lession l on l.groupId = i.groupId and l.lecturerId = i.lecturerId
join Schedule sche on sche.groupId = i.groupId and sche.subjectId = l.subjectId and i.slotId = sche.slotId
join Subject s on s.id = l.subjectId
where i.lecturerId = 'SonNT5' and i.[date] = '2024-02-28'
order by i.slotId

update isTaken set changeLecturer = ?
where (lecturerId = ? or changeLecturer = ?) and groupId = ? and date = ? and slotId = ?

select distinct l.lecturerId, l.subjectId, s.roomId, l.groupId, s.slotId, i.date, i.status, i.changeLecturer
                     from isTaken i
                     join Lession l on i.lecturerId = l.lecturerId and i.groupId = l.groupId
                     join Schedule s on s.groupId = l.groupId and s.subjectId = l.subjectId and i.slotId = s.slotId
                     where ((i.lecturerId = 'SonNT5' and i.changeLecturer is null) or i.changeLecturer = 'SonNT5')
                     and i.[date] >= '2024-01-01' and [date] <= '2024-02-01'
                     order by i.[date]

----
select distinct p.studentId, p.groupId, p.subjectId, s.year, t.monthBegin
from Participate p
join Schedule s on p.groupId = s.groupId and p.subjectId = s.subjectId
join Term t on t.id = s.termId
where p.studentId = 'HE172387' 
and ((s.year = 2023 and t.monthBegin > 12) or (s.year >= 2023+1))

select distinct p.subjectId
from Participate p
join Schedule s on p.groupId = s.groupId and p.subjectId = s.subjectId
join Term t on t.id = s.termId
where p.studentId = 'HE172387' and p.groupId = 'SE1817'
and ((s.year = 2023 and t.monthBegin > 12) or (s.year >= 2023+1))


