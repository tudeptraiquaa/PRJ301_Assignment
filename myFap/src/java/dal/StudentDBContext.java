/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Assessment;
import entity.Attendance;
import entity.Grade;
import entity.IDate;
import entity.IWeek;
import entity.Major;
import entity.Schedule;
import entity.Score;
import entity.Slot;
import entity.Student;
import entity.Subject;
import entity.Term;
import functiton.MyDate;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tu
 */
public class StudentDBContext extends DBContext<Student> {

    public ArrayList<Student> getStudentGroupBySubject(String groupId, String subjectId) {
        ArrayList<Student> students = new ArrayList<>();
        try {
            String sql = "select distinct s.id, s.name from Participate p "
                    + "join Student s on p.studentId = s.id "
                    + "where p.groupId = ? and p.subjectId = ? "
                    + "order by s.id";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, groupId);
            stm.setString(2, subjectId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getString("id"));
                s.setName(rs.getString("name"));
                students.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return students;
    }

    public Student getInformation(String id) {
        Student s = new Student();
        String sql = "select s.id as studentId, s.name as studentName, s.gender, "
                + "s.dob, s.address, s.majorId, m.name as majorName from Student s "
                + "join Major m on s.majorId = m.id where s.id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Major m = new Major();
                m.setId(rs.getString("majorId"));
                m.setName(rs.getString("majorName"));
                s.setId(rs.getString("studentId"));
                s.setName(rs.getString("studentName"));
                s.setGender(rs.getBoolean("gender"));
                s.setDob(rs.getDate("dob"));
                s.setAddress(rs.getString("address"));
                s.setMajor(m);
                return s;
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Term> getTermStudent(String id) {
        ArrayList<Term> terms = new ArrayList<>();
        String sql = "select distinct a.termId, a.name, a.year, a.monthBegin from\n"
                + "(select distinct p.subjectId, sche.termId, \n"
                + "t.name, t.monthBegin, sche.year\n"
                + "from Participate p\n"
                + "join Schedule sche on p.groupId = sche.groupId and p.subjectId = sche.subjectId\n"
                + "join Term t on sche.termId = t.id\n"
                + "where p.studentId = ?) a\n"
                + "order by a.year, a.monthBegin";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Term t = new Term();
                t.setId(rs.getString("termId"));
                t.setName(rs.getString("name"));
                t.setYear(rs.getInt("year"));
                terms.add(t);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return terms;
    }

    public ArrayList<Subject> getSubjectStudent(String id, String termId, int year) {
        ArrayList<Subject> subjects = new ArrayList<>();
        String sql = "select distinct p.subjectId, sub.name as subjectName, s.groupId\n"
                + "from Participate p\n"
                + "join Schedule s on p.groupId = s.groupId and p.subjectId = s.subjectId\n"
                + "join Subject sub on p.subjectId = sub.id\n"
                + "where p.studentId = ? and s.termId= ? and s.year= ?";
        PreparedStatement stm;
        ResultSet rs;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setString(2, termId);
            stm.setInt(3, year);
            rs = stm.executeQuery();
            while (rs.next()) {
                Subject s = new Subject();
                s.setId(rs.getString("subjectId"));
                s.setName(rs.getString("subjectName"));
                s.setGroupId(rs.getString("groupId"));
                subjects.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        for (Subject s : subjects) {
            sql = """
                  select a.date as dateBegin, b.date as dateEnd from
                  (select top 1 l.groupId, l.subjectId, i.date from isTaken i
                  join Lession l on i.groupId = l.groupId and i.lecturerId = l.lecturerId
                  where l.subjectId = ? and l.groupId = ?
                  order by i.date) a
                  join
                  (select top 1 l.groupId, l.subjectId, i.date from isTaken i
                  join Lession l on i.groupId = l.groupId and i.lecturerId = l.lecturerId
                  where l.subjectId = ? and l.groupId = ?
                  order by i.date desc) b
                  on a.groupId = b.groupId and a.subjectId = b.subjectId
                  """;
            try {
                stm = connection.prepareStatement(sql);
                stm.setString(1, s.getId());
                stm.setString(2, s.getGroupId());
                stm.setString(3, s.getId());
                stm.setString(4, s.getGroupId());
                rs = stm.executeQuery();
                if (rs.next()) {
                    IDate begin = new IDate(rs.getDate("dateBegin"));
                    IDate end = new IDate(rs.getDate("dateEnd"));
                    s.setDateBegin(begin);
                    s.setDateEnd(end);
                }

            } catch (SQLException ex) {
                Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return subjects;
    }

    public ArrayList<Grade> getGradeStudent(String subjectId) {
        ArrayList<Grade> grades = new ArrayList<>();
        String sql = "select g.assessmentId,\n"
                + "a.name as assessmentName, g.quantity, g.weight\n"
                + "from Grade g\n"
                + "join Assessment a on g.assessmentId = a.id\n"
                + "where g.subjectId = ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, subjectId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Grade g = new Grade();
                Assessment a = new Assessment();
                if ("FE-L".equals(rs.getString("assessmentId")) || "FE-GVR".equals(rs.getString("assessmentId"))) {
                    a.setId("FE");
                    a.setName(rs.getString("assessmentName"));
                } else if ("FE-L-R".equals(rs.getString("assessmentId")) || "FE-GVR-R".equals(rs.getString("assessmentId"))) {
                    a.setId("FER");
                    a.setName(rs.getString("assessmentName"));
                } else {
                    a.setId(rs.getString("assessmentId"));
                    a.setName(rs.getString("assessmentName"));
                }
                g.setAssessment(a);
                g.setQuantity(rs.getInt("quantity"));
                g.setWeight(rs.getFloat("weight"));
                grades.add(g);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return grades;
    }

    public ArrayList<Score> getScoreStudent(String id, String subjectId, String termId, int year) {
        StudentDBContext stuDB = new StudentDBContext();
        ArrayList<Score> scores = new ArrayList<>();
        ArrayList<Grade> grades = stuDB.getGradeStudent(subjectId);

        for (Grade g : grades) {
            if (g.getQuantity() == 1) {
                Score s = new Score();
                s.setAssessment(g.getAssessment());
                s.setWeight(g.getWeight());
                scores.add(s);
            } else {
                for (int i = 1; i <= g.getQuantity(); i++) {
                    Assessment a = new Assessment();
                    a.setId(g.getAssessment().getId());
                    a.setName(g.getAssessment().getName() + " " + i);
                    Score s = new Score();
                    s.setAssessment(a);
                    s.setWeight(g.getWeight());
                    scores.add(s);
                }
            }
        }
        String sql = """
                     select  g.assessmentId, s.value,
                     a.name as assessmentName, g.quantity, g.weight
                     from Grade g
                     join Assessment a on g.assessmentId = a.id
                     left join 
                     (
                     select s.studentId, s.subjectId, s.assessmentId, s.value from Score s
                     where s.studentId = ? and s.termId = ? and s.year = ?
                     ) s on s.assessmentId = g.assessmentId and s.subjectId = g.subjectId
                     where g.subjectId = ?
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setString(2, termId);
            stm.setInt(3, year);
            stm.setString(4, subjectId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                for (Score s : scores) {
                    if (s.getAssessment().getName().equalsIgnoreCase(rs.getString("assessmentName")) || s.getAssessment().getId().equalsIgnoreCase(rs.getString("assessmentId"))) {
                        String value = rs.getString("value");
                        if (s.getValue() == null && value != null) {
                            s.setValue(Float.valueOf(value));
                            break;
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return scores;
    }

    public ArrayList<Integer> getScheduleYear(String studentId) {
        ArrayList<Integer> years = new ArrayList<>();
        String sql = """
                     select distinct sche.year from Participate p
                     join Schedule sche on p.groupId = sche.groupId and sche.subjectId = p.subjectId
                     where p.studentId = ?
                     order by sche.year
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int y = rs.getInt("year");
                years.add(y);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return years;
    }

    public ArrayList<Slot> getSlot() {
        ArrayList<Slot> slots = new ArrayList<>();
        String sql = "select id, startTime, endTime from SLot";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Slot s = new Slot();
                s.setId(rs.getInt("id"));
                s.setStartTime(rs.getString("startTime"));
                s.setEndTime(rs.getString("endTime"));
                slots.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return slots;
    }

    public ArrayList<Schedule> getScheduleStudent(String studentId, int week, int year) {
        MyDate myDate = new MyDate();
        IWeek iWeek = myDate.getWeek(week, year);
        ArrayList<Schedule> schedules = new ArrayList<>();
        String sql = """
                     select distinct p.studentId, p.subjectId, sche.roomId, l.groupId, sche.slotId, i.date, a.isPresent as [status]
                     from Participate p 
                     join Lession l on p.groupId = l.groupId and p.subjectId = l.subjectId
                     join isTaken i on i.lecturerId = l.lecturerId and i.groupId = l.groupId
                     join Schedule sche on sche.groupId = p.groupId and sche.subjectId = p.subjectId and i.slotId = sche.slotId
                     left join Attendance a on a.date = i.date and a.groupId = p.groupId and a.subjectId = p.subjectId and p.studentId = a.studentId
                     where p.studentId = ?
                     and i.date >= ? and i.date <= ?
                     order by i.date, p.subjectId
                     """;

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentId);
            stm.setString(2, iWeek.getFromDate().toString());
            stm.setString(3, iWeek.getToDate().toString());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Schedule s = new Schedule();
                s.setId(rs.getString("studentId"));
                s.setSubjectId(rs.getString("subjectId"));
                s.setRoomId(rs.getString("roomId"));
                s.setGroupId(rs.getString("groupId"));
                IDate d = new IDate(rs.getDate("date"));
                s.setDate(d);
                s.setSlotId(rs.getInt("slotId"));
                s.setStatus(rs.getBoolean("status"));
                schedules.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return schedules;
    }

    public ArrayList<Schedule> getScheduleStudent(String studentId, String from, String to) {
        ArrayList<Schedule> schedules = new ArrayList<>();
        String sql = """
                     select distinct p.studentId, p.subjectId, sche.roomId, l.groupId, sche.slotId, i.date, a.isPresent as [status]
                     from Participate p 
                     join Lession l on p.groupId = l.groupId and p.subjectId = l.subjectId
                     join isTaken i on i.lecturerId = l.lecturerId and i.groupId = l.groupId
                     join Schedule sche on sche.groupId = p.groupId and sche.subjectId = p.subjectId and i.slotId = sche.slotId
                     left join Attendance a on a.date = i.date and a.groupId = p.groupId and a.subjectId = p.subjectId and p.studentId = a.studentId
                     where p.studentId = ?
                     and i.date >= ? and i.date <= ?
                     order by i.date, p.subjectId
                     """;

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentId);
            stm.setString(2, from);
            stm.setString(3, to);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Schedule s = new Schedule();
                s.setId(rs.getString("studentId"));
                s.setSubjectId(rs.getString("subjectId"));
                s.setRoomId(rs.getString("roomId"));
                s.setGroupId(rs.getString("groupId"));
                IDate d = new IDate(rs.getDate("date"));
                s.setDate(d);
                s.setSlotId(rs.getInt("slotId"));
                s.setStatus(rs.getBoolean("status"));
                schedules.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return schedules;
    }

    public Attendance getSchedule(String id, String groupId, String subjectId, String date) {
        Attendance a = new Attendance();
        String sql = """
                     select i.lecturerId, i.changeLecturer, i.status, s.name, a.isPresent
                     from isTaken i 
                     join Lession l on l.groupId = i.groupId and l.lecturerId = i.lecturerId
                     join Participate p on i.groupId = p.groupId and p.subjectId = l.subjectId
                     join Subject s on s.id = p.subjectId
                     left join Attendance a on a.groupId = p.groupId and a.subjectId = p.subjectId and a.date = ? and a.studentId = ?
                     where i.[date] = ? and p.studentId = ? and p.groupId = ? and p.subjectId = ?
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(2, id);
            stm.setString(4, id);
            stm.setString(5, groupId);
            stm.setString(6, subjectId);
            stm.setString(3, date);
            stm.setString(1, date);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                if (rs.getString("changeLecturer") != null) {
                    a.setLecturerId(rs.getString("changeLecturer"));
                } else {
                    a.setLecturerId(rs.getString("lecturerId"));
                }
                a.setSubjectName(rs.getString("name"));
                a.setStatus(rs.getBoolean("isPresent"));
                a.setTakenGroup(rs.getBoolean("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return a;
    }

    public ArrayList<Attendance> getAttendanceStudent(String studentId, String subjectId, String termId, int year) {
        ArrayList<Attendance> attendances = new ArrayList<>();
        String sql = """
                     select p.studentId, sche.[weekday], i.[date], i.slotId, s.startTime, s.endTime, 
                     sche.roomId, l.lecturerId, p.groupId, a.isPresent, a.[description], i.status as isTakenGroup
                     from Participate p
                     join Lession l on p.groupId = l.groupId and p.subjectId = l.subjectId
                     join isTaken i on i.groupId = l.groupId and i.lecturerId = l.lecturerId
                     join Schedule sche on sche.groupId = p.groupId and sche.subjectId = p.subjectId and sche.slotId = i.slotId
                     join Slot s on s.id = i.slotId
                     left join Attendance a on a.studentId = p.studentId and a.groupId = p.groupId
                     and a.subjectId = p.subjectId and a.slotId = i.slotId and a.[date] = i.[date]
                     where p.studentId = ? and p.subjectId = ? and sche.termId = ? and sche.year = ?
                     order by i.date
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentId);
            stm.setString(2, subjectId);
            stm.setString(3, termId);
            stm.setInt(4, year);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Attendance a = new Attendance();
                a.setDate(new IDate(rs.getDate("date")));
                Slot s = new Slot();
                s.setId(rs.getInt("slotId"));
                s.setStartTime(rs.getString("startTime"));
                s.setEndTime(rs.getString("endTime"));
                a.setSlot(s);
                a.setRoomId(rs.getString("roomId"));
                a.setLecturerId(rs.getString("lecturerId"));
                a.setGroupId(rs.getString("groupId"));
                a.setStatus(rs.getBoolean("isPresent"));
                a.setDescription(rs.getString("description"));
                a.setTakenGroup(rs.getBoolean("isTakenGroup"));
                attendances.add(a);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return attendances;
    }

    public void updateScoreStudent(ArrayList<Score> scores) {
        String sql = """
                     delete from Score
                     where studentId = ? and subjectId = ?
                     and termId = ? and year = ?
                     """;
        PreparedStatement stm;
        Score s = scores.get(0);
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, s.getStudentId());
            stm.setString(2, s.getSubjectId());
            stm.setString(3, s.getTermId());
            stm.setInt(4, s.getYear());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            for (Score score : scores) {
                if (score.getValue() == null) {
                    sql = """
                            insert into Score (studentId, assessmentId, subjectId, termId, year)
                            values (?, ?, ?, ?, ?)
                            """;
                    stm = connection.prepareStatement(sql);
                    stm.setString(1, score.getStudentId());
                    stm.setString(2, score.getAssessment().getId());
                    stm.setString(3, score.getSubjectId());
                    stm.setString(4, score.getTermId());
                    stm.setInt(5, score.getYear());
                    stm.executeUpdate();
                } else {
                    sql = """
                           insert into Score (studentId, assessmentId, subjectId, value, termId, year)
                           values (?, ?, ?, ?, ?, ?)
                          """;
                    stm = connection.prepareStatement(sql);
                    stm.setString(1, score.getStudentId());
                    stm.setString(2, score.getAssessment().getId());
                    stm.setString(3, score.getSubjectId());
                    stm.setFloat(4, score.getValue());
                    stm.setString(5, score.getTermId());
                    stm.setInt(6, score.getYear());
                    stm.executeUpdate();
                }

            }

        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static void main(String[] args) {
        StudentDBContext stuDB = new StudentDBContext();
        ArrayList<Schedule> s = stuDB.getScheduleStudent("HE172387", "2024-02-02", "2024-03-01");
        for (Schedule a : s) {
            System.out.println(a.getSubjectId());
        }
    }
}
