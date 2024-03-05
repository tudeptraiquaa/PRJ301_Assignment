/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Attendance;
import entity.Calendar;
import entity.IEntity;
import entity.RequireChangeGroup;
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
            stm.setInt(2, year);
            stm.setInt(3, month);
            stm.setInt(4, year + 1);
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
            stm.setInt(3, year);
            stm.setInt(4, month);
            stm.setInt(5, year + 1);
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

    public String getGroupStudentFuture(String id, int month, int year, String subjectId) {
        month = 12;
        year = 2023;
        String sql = """
                     select distinct p.*, t.monthBegin, s.year from Participate p
                     join Schedule s on s.groupId = p.groupId and s.subjectId = p.subjectId
                     join Term t on t.id = s.termId
                     where studentId = ? and p.subjectId = ?
                      and ((s.year = ? and t.monthBegin > ?) or (s.year >= ?))
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setString(2, subjectId);
            stm.setInt(3, year);
            stm.setInt(4, month);
            stm.setInt(5, year + 1);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("groupId");
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void addRequireChangeGroup(String idFrom, String groupIdFrom, String idTo, String groupIdTo,
            String subjectId, String termId, int year, String requsetDate) {
        RequireChangeGroup r = getRequireChangeGroup(idFrom, subjectId);
        if (r != null) {
            String sql = """
                         update ChangeGroup set idTo = ?, groupIdTo = ?, requestDate = ?, termId = ?, [year] = ?
                         where [status] = '-1' and idFrom = ? and subjectId = ? and groupIdFrom = ?
                         """;
            try {
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, idTo);
                stm.setString(2, groupIdTo);
                stm.setString(3, requsetDate);
                stm.setString(4, termId);
                stm.setInt(5, year);
                stm.setString(6, idFrom);
                stm.setString(7, subjectId);
                stm.setString(8, groupIdFrom);
                stm.executeUpdate();
                return;
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        String sql = """
                     insert into ChangeGroup 
                     (idFrom, groupIdFrom, idTo, groupIdTo, subjectId, termId, [year], requestDate, [status])
                     values (?, ?, ?, ?, ?, ?, ?, ?, '-1')
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, idFrom);
            stm.setString(2, groupIdFrom);
            stm.setString(3, idTo);
            stm.setString(4, groupIdTo);
            stm.setString(5, subjectId);
            stm.setString(6, termId);
            stm.setInt(7, year);
            stm.setString(8, requsetDate);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<RequireChangeGroup> getRequiresChangeGroup(String id) {
        ArrayList<RequireChangeGroup> request = new ArrayList<>();
        String sql = """
                     select subjectId, groupIdFrom, idTo, groupIdTo, requestDate, [status]
                     from ChangeGroup
                     where idFrom = ? and status = '-1'
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                RequireChangeGroup r = new RequireChangeGroup();
                r.setSubjectId(rs.getString("subjectId"));
                r.setGroupIdFrom(rs.getString("groupIdFrom"));
                r.setIdTo(rs.getString("idTo"));
                r.setGroupIdTo(rs.getString("groupIdTo"));
                r.setDateRequire(rs.getString("requestDate"));
                r.setStatus(rs.getString("status"));
                request.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return request;
    }

    public ArrayList<RequireChangeGroup> getRequiresChangeGroupProcessed(String id) {
        ArrayList<RequireChangeGroup> request = new ArrayList<>();
        String sql = """
                     select subjectId, groupIdFrom, idTo, groupIdTo, requestDate, [status], comment, dateProcessing
                     from ChangeGroup
                     where idFrom = ? and status != -1
                     order by dateProcessing
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                RequireChangeGroup r = new RequireChangeGroup();
                r.setSubjectId(rs.getString("subjectId"));
                r.setGroupIdFrom(rs.getString("groupIdFrom"));
                r.setIdTo(rs.getString("idTo"));
                r.setGroupIdTo(rs.getString("groupIdTo"));
                r.setDateRequire(rs.getString("requestDate"));
                r.setStatus(rs.getString("status"));
                r.setComment(rs.getString("comment"));
                r.setDateProcessing(rs.getTimestamp("dateProcessing"));
                request.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return request;
    }

    public RequireChangeGroup getRequireChangeGroup(String id, String subjectId) {
        RequireChangeGroup request = new RequireChangeGroup();
        String sql = """
                     select subjectId, groupIdFrom, idTo, groupIdTo, requestDate, [status]
                     from ChangeGroup
                     where idFrom = ? and status = '-1' and subjectId = ?
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setString(2, subjectId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                RequireChangeGroup r = new RequireChangeGroup();
                r.setSubjectId(rs.getString("subjectId"));
                r.setGroupIdFrom(rs.getString("groupIdFrom"));
                r.setIdTo(rs.getString("idTo"));
                r.setGroupIdTo(rs.getString("groupIdTo"));
                r.setDateRequire(rs.getString("requestDate"));
                r.setStatus(rs.getString("status"));
                return r;
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<RequireChangeGroup> getRequiresChangeGroup() {
        ArrayList<RequireChangeGroup> request = new ArrayList<>();
        String sql = """
                     select idFrom, groupIdFrom, subjectId, idTo, groupIdTo, requestDate, [status], comment
                     from ChangeGroup where [status] = '-1'
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                RequireChangeGroup r = new RequireChangeGroup();
                r.setIdFrom(rs.getString("idFrom"));
                r.setSubjectId(rs.getString("subjectId"));
                r.setGroupIdFrom(rs.getString("groupIdFrom"));
                r.setIdTo(rs.getString("idTo"));
                r.setGroupIdTo(rs.getString("groupIdTo"));
                r.setDateRequire(rs.getString("requestDate"));
                r.setStatus(rs.getString("status"));
                r.setComment(rs.getString("comment"));
                request.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return request;
    }

    public void processRequires(String status, Timestamp timeRecord) {
        if (status.equals("0")) {
            String sql = """
                         update ChangeGroup set [status] = '0', dateProcessing = ?
                         where [status] = '-1'
                         """;
            try {
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setTimestamp(1, timeRecord);
                stm.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        if (status.equals("1")) {
            ArrayList<RequireChangeGroup> requires = getRequiresChangeGroup();
            for (RequireChangeGroup r : requires) {
                ArrayList<Calendar> calendar_from = new ArrayList<>();
                ArrayList<Calendar> calendar_to = new ArrayList<>();

                String sql = """
                              select s.slotId, s.weekday, s.termId
                              from Participate p
                              join Schedule s on s.groupId = p.groupId and s.subjectId = p.subjectId
                              where p.studentId = ? and p.subjectId = ? and p.groupId = ?
                              """;
                PreparedStatement stm;
                try {
                    stm = connection.prepareStatement(sql);
                    stm.setString(1, r.getIdFrom());
                    stm.setString(2, r.getSubjectId());
                    stm.setString(3, r.getGroupIdFrom());
                    ResultSet rs = stm.executeQuery();
                    while (rs.next()) {
                        Calendar s = new Calendar();
                        s.setSlotId(rs.getInt("slotId"));
                        s.setWeekday(rs.getInt("weekday"));
                        s.setTermId(rs.getString("termId"));
                        calendar_from.add(s);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    stm = connection.prepareStatement(sql);
                    stm.setString(1, r.getIdTo());
                    stm.setString(2, r.getSubjectId());
                    stm.setString(3, r.getGroupIdTo());
                    ResultSet rs = stm.executeQuery();
                    while (rs.next()) {
                        Calendar s = new Calendar();
                        s.setSlotId(rs.getInt("slotId"));
                        s.setWeekday(rs.getInt("weekday"));
                        s.setTermId(rs.getString("termId"));
                        calendar_to.add(s);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
                boolean flag = true;
                String sql_calendar = """
                                    select s.slotId, s.[weekday], t.monthBegin, s.year, s.subjectId
                                    from Participate p
                                    join Schedule s on s.groupId = p.groupId and s.subjectId = p.subjectId
                                    join Term t on t.id = s.termId
                                    where p.studentId = ? and s.termId = ?
                                    and p.subjectId != ? and s.slotId = ? and s.[weekday] = ?
                                     """;
                for (Calendar c_f : calendar_from) {
                    try {
                        stm = connection.prepareStatement(sql_calendar);
                        stm.setString(1, r.getIdTo());
                        stm.setString(2, c_f.getTermId());
                        stm.setString(3, r.getSubjectId());
                        stm.setInt(4, c_f.getSlotId());
                        stm.setInt(5, c_f.getWeekday());
                        ResultSet rs = stm.executeQuery();
                        if (rs.next()) {
                            flag = false;
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                for (Calendar c_t : calendar_to) {
                    try {
                        stm = connection.prepareStatement(sql_calendar);
                        stm.setString(1, r.getIdFrom());
                        stm.setString(2, c_t.getTermId());
                        stm.setString(3, r.getSubjectId());
                        stm.setInt(4, c_t.getSlotId());
                        stm.setInt(5, c_t.getWeekday());
                        ResultSet rs = stm.executeQuery();
                        if (rs.next()) {
                            flag = false;
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                if (flag) {
                    String sql_update = """
                                        update Participate set groupId = ? 
                                        where  studentId =  ? and  subjectId =  ? and  groupId =  ?
                                        """;
                    try {
                        stm = connection.prepareStatement(sql_update);
                        stm.setString(1, r.getGroupIdTo());
                        stm.setString(2, r.getIdFrom());
                        stm.setString(3, r.getSubjectId());
                        stm.setString(4, r.getGroupIdFrom());
                        stm.executeUpdate();
                    } catch (SQLException ex) {
                        Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    try {
                        stm = connection.prepareStatement(sql_update);
                        stm.setString(1, r.getGroupIdFrom());
                        stm.setString(2, r.getIdTo());
                        stm.setString(3, r.getSubjectId());
                        stm.setString(4, r.getGroupIdTo());
                        stm.executeUpdate();
                    } catch (SQLException ex) {
                        Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    String sql_change = """
                                        update ChangeGroup set [status] = '1', dateProcessing = ?
                                        where [status] = '-1' and idFrom = ? and subjectId = ? and groupIdFrom = ?
                                        """;
                    try {
                        stm = connection.prepareStatement(sql_change);
                        stm.setTimestamp(1, timeRecord);
                        stm.setString(2, r.getIdFrom());
                        stm.setString(3, r.getSubjectId());
                        stm.setString(4, r.getGroupIdFrom());
                        stm.executeUpdate();
                    } catch (SQLException ex) {
                        Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    String sql_change = """
                                        update ChangeGroup set comment = 'Students have the same time slot in another subject'
                                        where [status] = '-1' and idFrom = ? and subjectId = ? and groupIdFrom = ?
                                        """;
                    try {
                        stm = connection.prepareStatement(sql_change);
                        stm.setTimestamp(1, timeRecord);
                        stm.setString(2, r.getIdFrom());
                        stm.setString(3, r.getSubjectId());
                        stm.setString(4, r.getGroupIdFrom());
                        stm.executeUpdate();
                    } catch (SQLException ex) {
                        Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }
    }

    public boolean processRequireStudent(RequireChangeGroup r) {
        if (r.getStatus().equals("0")) {
            String sql = """
                         update ChangeGroup set [status] = '0', dateProcessing = ?, comment = ?
                         where [status] = '-1' and idFrom = ? and subjectId = ?
                         """;
            try {
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setTimestamp(1, r.getDateProcessing());
                stm.setString(2, r.getComment());
                stm.setString(3, r.getIdFrom());
                stm.setString(4, r.getSubjectId());
                stm.executeUpdate();

            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (r.getStatus().equals("1")) {
            ArrayList<Calendar> calendar_from = new ArrayList<>();
            ArrayList<Calendar> calendar_to = new ArrayList<>();
            String sql = """
                         select s.slotId, s.weekday, s.termId
                         from Participate p
                         join Schedule s on s.groupId = p.groupId and s.subjectId = p.subjectId
                         where p.studentId = ? and p.subjectId = ? and p.groupId = ?
                         """;
            PreparedStatement stm;
            try {
                stm = connection.prepareStatement(sql);
                stm.setString(1, r.getIdFrom());
                stm.setString(2, r.getSubjectId());
                stm.setString(3, r.getGroupIdFrom());
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Calendar c = new Calendar();
                    c.setSlotId(rs.getInt("slotId"));
                    c.setWeekday(rs.getInt("weekday"));
                    c.setTermId(rs.getString("termId"));
                    calendar_from.add(c);
                }
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
            try {
                stm = connection.prepareStatement(sql);
                stm.setString(1, r.getIdTo());
                stm.setString(2, r.getSubjectId());
                stm.setString(3, r.getGroupIdTo());
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Calendar s = new Calendar();
                    s.setSlotId(rs.getInt("slotId"));
                    s.setWeekday(rs.getInt("weekday"));
                    s.setTermId(rs.getString("termId"));
                    calendar_to.add(s);
                }
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
            boolean flag = true;
            String sql_calendar = """
                                  select s.slotId, s.[weekday], t.monthBegin, s.year, s.subjectId
                                  from Participate p
                                  join Schedule s on s.groupId = p.groupId and s.subjectId = p.subjectId
                                  join Term t on t.id = s.termId
                                  where p.studentId = ? and s.termId = ?
                                  and p.subjectId != ? and s.slotId = ? and s.[weekday] = ?
                                  """;
            for (Calendar c_f : calendar_from) {
                try {
                    stm = connection.prepareStatement(sql_calendar);
                    stm.setString(1, r.getIdTo());
                    stm.setString(2, c_f.getTermId());
                    stm.setString(3, r.getSubjectId());
                    stm.setInt(4, c_f.getSlotId());
                    stm.setInt(5, c_f.getWeekday());
                    ResultSet rs = stm.executeQuery();
                    if (rs.next()) {
                        flag = false;
                        break;
                    }
                } catch (SQLException ex) {
                    flag = false;
                    Logger.getLogger(GroupDBContext.class
                            .getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (flag) {
                for (Calendar c_t : calendar_to) {
                    try {
                        stm = connection.prepareStatement(sql_calendar);
                        stm.setString(1, r.getIdFrom());
                        stm.setString(2, c_t.getTermId());
                        stm.setString(3, r.getSubjectId());
                        stm.setInt(4, c_t.getSlotId());
                        stm.setInt(5, c_t.getWeekday());
                        ResultSet rs = stm.executeQuery();
                        if (rs.next()) {
                            flag = false;
                            break;
                        }
                    } catch (SQLException ex) {
                        flag=false;
                        Logger.getLogger(GroupDBContext.class
                                .getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            if (flag) {
                String sql_update = """
                                    update Participate set groupId = ?
                                    where studentId = ? and subjectId = ? and groupId = ?
                                    """;
                try {
                    stm = connection.prepareStatement(sql_update);
                    stm.setString(1, r.getGroupIdTo());
                    stm.setString(2, r.getIdFrom());
                    stm.setString(3, r.getSubjectId());
                    stm.setString(4, r.getGroupIdFrom());
                    stm.executeUpdate();

                } catch (SQLException ex) {
                    Logger.getLogger(GroupDBContext.class
                            .getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    stm = connection.prepareStatement(sql_update);
                    stm.setString(1, r.getGroupIdFrom());
                    stm.setString(2, r.getIdTo());
                    stm.setString(3, r.getSubjectId());
                    stm.setString(4, r.getGroupIdTo());
                    stm.executeUpdate();

                } catch (SQLException ex) {
                    Logger.getLogger(GroupDBContext.class
                            .getName()).log(Level.SEVERE, null, ex);
                }

                String sql_change = """
                                    update ChangeGroup set [status] = '1', dateProcessing = ?, comment = ?
                                    where [status] = '-1' and idFrom = ? and subjectId = ? and groupIdFrom = ?
                                    """;
                try {
                    stm = connection.prepareStatement(sql_change);
                    stm.setTimestamp(1, r.getDateProcessing());
                    stm.setString(2, r.getComment());
                    stm.setString(3, r.getIdFrom());
                    stm.setString(4, r.getSubjectId());
                    stm.setString(5, r.getGroupIdFrom());
                    stm.executeUpdate();

                } catch (SQLException ex) {
                    Logger.getLogger(GroupDBContext.class
                            .getName()).log(Level.SEVERE, null, ex);
                }
                return true;
            } else {
                String sql_change = """
                                    update ChangeGroup set comment = 'Students have the same time slot in another subject', dateProcessing = ?
                                    where [status] = '-1' and idFrom = ? and subjectId = ? and groupIdFrom = ?
                                    """;
                try {
                    stm = connection.prepareStatement(sql_change);
                    stm.setTimestamp(1, r.getDateProcessing());
                    stm.setString(2, r.getIdFrom());
                    stm.setString(3, r.getSubjectId());
                    stm.setString(4, r.getGroupIdFrom());
                    stm.executeUpdate();

                } catch (SQLException ex) {
                    Logger.getLogger(GroupDBContext.class
                            .getName()).log(Level.SEVERE, null, ex);
                }
                return false;
            }
        }
        return false;
    }

    public static void main(String[] args) {
        GroupDBContext gDB = new GroupDBContext();
        ArrayList<RequireChangeGroup> gs = gDB.getRequiresChangeGroupProcessed("HE172387");
        for (RequireChangeGroup s : gs) {
            System.out.println(s.getDateRequire());
        }
    }
}
