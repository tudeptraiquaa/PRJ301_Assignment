/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Attendance;
import entity.IEntity;
import entity.Term;
import java.util.ArrayList;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tu
 */
public class GroupDBContext extends DBContext<IEntity> {

    public ArrayList<Attendance> viewAttendanceGroup(String groupId, String subjectId, String date, int slotId) {
        ArrayList<Attendance> attendances = new ArrayList<>();
        String sql = """
                    select a.groupId, a.studentId, s.name as studentName, a.isPresent, a.taker, a.description, a.timeRecord, a.slotId
                    from Attendance a
                    join Student s on a.studentId = s.id
                    where subjectId = ? and groupId = ? and [date] = ? and slotId = ?
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(2, groupId);
            stm.setString(1, subjectId);
            stm.setString(3, date);
            stm.setInt(4, slotId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                while (rs.next()) {
                    Attendance a = new Attendance();
                    a.setStudentId(rs.getString("studentId"));
                    a.setGroupId(rs.getString("groupId"));
                    a.setStudentName(rs.getString("studentName"));
                    a.setStatus(rs.getBoolean("isPresent"));
                    a.setTaker(rs.getString("taker"));
                    if (rs.getString("description") != null) {
                        a.setDescription(rs.getString("description"));
                    } else {
                        a.setDescription(" ");
                    }
                    a.setTimeRecord(rs.getTimestamp("timeRecord"));
                    a.setSlotId(slotId);
                    attendances.add(a);
                }
            } else {
                sql = """
                      select p.groupId, p.studentId, s.name as studentName
                      from Participate p
                      join Student s on p.studentId = s.id
                      where p.subjectId = ? and p.groupId = ?
                      order by s.id
                      """;
                stm = connection.prepareStatement(sql);
                stm.setString(1, subjectId);
                stm.setString(2, groupId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Attendance a = new Attendance();
                    a.setStudentId(rs.getString("studentId"));
                    a.setGroupId(rs.getString("groupId"));
                    a.setStudentName(rs.getString("studentName"));
                    a.setStatus(false);
                    a.setSlotId(slotId);
                    attendances.add(a);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return attendances;
    }

    public void attendance(ArrayList<Attendance> attendances) {
        String sql = """
                     insert into Attendance (studentId, subjectId, groupId, isPresent, [description], taker, timeRecord, [date], slotId)
                     values (?, ?, ?, ?, ?, ?, ?, ?, ?)
                     """;
        for (Attendance a : attendances) {
            try {
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, a.getStudentId());
                stm.setString(2, a.getSubjectId());
                stm.setString(3, a.getGroupId());
                stm.setBoolean(4, a.isStatus());
                stm.setString(5, a.getDescription());
                stm.setString(6, a.getTaker());
                stm.setTimestamp(7, a.getTimeRecord());
                stm.setString(8, a.getDate().toString());
                stm.setInt(9, a.getSlotId());
                stm.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void isTakenGroup(String lecturerId, String groupId, String date, String slotId, Timestamp timeRecord) {
        try {
            String sql = """
                         update isTaken set [status] = 1, timeRecord = ?
                         where ((lecturerId = ? and changeLecturer is null) or changeLecturer = ?)
                         and groupId = ? and [date] = ? and slotId = ?
                         """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setTimestamp(1, timeRecord);
            stm.setString(2, lecturerId);
            stm.setString(3, lecturerId);
            stm.setString(4, groupId);
            stm.setString(5, date);
            stm.setInt(6, Integer.parseInt(slotId.trim()));
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<Term> getTermGroup() {
        ArrayList<Term> terms = new ArrayList<>();
        String sql = """
                     select distinct s.termId, t.name as termName, s.year, t.monthBegin, t.monthEnd
                     from Schedule s
                     join Term t on s.termId = t.id
                     order by s.year, t.monthBegin
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Term t = new Term();
                t.setId(rs.getString("termId"));
                t.setName(rs.getString("termName"));
                t.setYear(rs.getInt("year"));
                t.setMonthBegin(rs.getInt("monthBegin"));
                t.setMonthEnd(rs.getInt("monthEnd"));
                terms.add(t);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return terms;
    }

    public ArrayList<String> getGroupByTerm(String termId, int year) {
        ArrayList<String> groupsId = new ArrayList<>();
        String sql = """
                     select distinct s.groupId from Schedule s
                     where s.termId = ? and s.year = ?
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, termId);
            stm.setInt(2, year);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String gId = rs.getString("groupId");
                groupsId.add(gId);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groupsId;
    }

    public ArrayList<String> getSubjectGroupByTerm(String groupId, String termId, String year) {
        ArrayList<String> subjectsId = new ArrayList<>();
        String sql = """
                    select distinct s.subjectId from Schedule s
                    where s.groupId = ? and s.termId = ? and s.year = ?
                    """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, groupId);
            stm.setString(2, termId);
            stm.setInt(3, Integer.parseInt(year.trim()));
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String s = rs.getString("subjectId");
                subjectsId.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subjectsId;
    }

    public boolean groupIsTaken(String groupId, String subjectId, String date) {
        String sql = """
                     select i.[status] from isTaken i
                     join Lession l on i.lecturerId = l.lecturerId and i.groupId = l.groupId
                     where l.subjectId = ? and l.groupId = ? and i.[date] = ?
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, subjectId);
            stm.setString(2, groupId);
            stm.setString(3, date);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("status");
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void editAttendance(ArrayList<Attendance> oldA, ArrayList<Attendance> newA, boolean isTaken) {
        if (!isTaken) {
            attendance(newA);
            return;
        }
        for (int i = 0; i < oldA.size(); i++) {
            if (oldA.get(i).isStatus() != newA.get(i).isStatus()
                    || !newA.get(i).getDescription().equalsIgnoreCase(oldA.get(i).getDescription())) {
                try {
                    String sql = """
                                update Attendance set isPresent = ?, [description] = ?, timeRecord = ?, taker = ?
                                where studentId = ? and subjectId = ? and [date] = ? and slotId = ?
                                """;
                    PreparedStatement stm = connection.prepareStatement(sql);
                    stm.setBoolean(1, newA.get(i).isStatus());
                    stm.setString(2, newA.get(i).getDescription());
                    stm.setTimestamp(3, newA.get(i).getTimeRecord());
                    stm.setString(4, newA.get(i).getTaker());
                    stm.setString(5, newA.get(i).getStudentId());
                    stm.setString(6, newA.get(i).getSubjectId());
                    stm.setString(7, newA.get(i).getDate().toString());
                    stm.setInt(8, newA.get(i).getSlotId());
                    stm.executeUpdate();
                } catch (SQLException ex) {
                    Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
        }
    }

    public ArrayList<String> getGroupStudentInFuture(String id, int month, int year) {
        ArrayList<String> groups = new ArrayList<>();
        String sql = """
                     select distinct p.groupId
                     from Participate p
                     join Schedule s on p.groupId = s.groupId and p.subjectId = s.subjectId
                     join Term t on t.id = s.termId
                     where p.studentId = ? 
                     and ((s.year = ? and t.monthBegin > ?) or (s.year >= ?))
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setInt(2, 2023);
            stm.setInt(3, 12);
            stm.setInt(4, 2023 + 1);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String g = rs.getString("groupId");
                groups.add(g);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groups;
    }

    public ArrayList<String> getSubjectStudentInFuture(String id, int month, int year, String groupId) {
        ArrayList<String> subjectsId = new ArrayList<>();
        String sql = """
                     select distinct p.subjectId
                     from Participate p
                     join Schedule s on p.groupId = s.groupId and p.subjectId = s.subjectId
                     join Term t on t.id = s.termId
                     where p.studentId = ? and p.groupId = ?
                     and ((s.year = ? and t.monthBegin > ?) or (s.year >= ?))
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setString(2, groupId);
            stm.setInt(3, 2023);
            stm.setInt(4, 12);
            stm.setInt(5, 2024);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String s = rs.getString("subjectId");
                subjectsId.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subjectsId;
    }

    public static void main(String[] args) {
        GroupDBContext gDB = new GroupDBContext();
        ArrayList<String> gs = gDB.getSubjectStudentInFuture("HE172387", 2, 2023, "SE1817");
        for (String s : gs) {
            System.out.println(s);
        }
    }
}
