/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.IDate;
import entity.IWeek;
import entity.Lecturer;
import entity.Schedule;
import entity.Slot;
import functiton.MyDate;
import java.util.ArrayList;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tu
 */
public class LecturerDBContext extends DBContext<Lecturer> {

    public Lecturer getInformation(String lecturerId) {
        Lecturer l = new Lecturer();
        String sql = """
                     select id, [name], phoneNumber, qualification from Lecturer
                     where id = ?""";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lecturerId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                l.setId(rs.getString("id"));
                l.setName(rs.getString("name"));
                l.setPhoneNumber(rs.getString("phoneNumber"));
                l.setQualification(rs.getString("qualification"));
                return l;
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
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

    public ArrayList<Integer> getScheduleYear(String lecturerId) {
        ArrayList<Integer> years = new ArrayList<>();
        String sql = """
                     select distinct s.year from Lession l
                     join Schedule s on l.groupId = s.groupId and l.subjectId = s.subjectId
                     where l.lecturerId = ?
                     order by s.year""";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lecturerId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Integer y = rs.getInt("year");
                years.add(y);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return years;
    }

    public ArrayList<Schedule> getScheduleLecturer(String lecturerId, int week, int year) {
        MyDate myDate = new MyDate();
        IWeek iWeek = myDate.getWeek(week, year);
        ArrayList<Schedule> schedules = new ArrayList<>();
        String sql = """
                     select distinct l.lecturerId, l.subjectId, s.roomId, l.groupId, s.slotId, i.date, i.status, i.changeLecturer, i.changeRoom, i.changeSlot
                     from isTaken i
                     join Lession l on i.lecturerId = l.lecturerId and i.groupId = l.groupId and i.subjectId = l.subjectId
                     join Schedule s on s.groupId = l.groupId and s.subjectId = l.subjectId and i.slotId = s.slotId
                     where ((i.lecturerId = ? and i.changeLecturer is null) or i.changeLecturer = ?) 
                     and i.[date] >= ? and [date] <= ?
                     order by i.[date]
                     """;

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lecturerId);
            stm.setString(2, lecturerId);
            stm.setString(3, iWeek.getFromDate().toString());
            stm.setString(4, iWeek.getToDate().toString());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Schedule s = new Schedule();
                if (rs.getString("changeLecturer") == null) {
                    s.setId(rs.getString("lecturerId"));
                } else {
                    s.setId(rs.getString("changeLecturer"));
                }
                s.setSubjectId(rs.getString("subjectId"));
                s.setRoomId(rs.getString("changeRoom")==null?rs.getString("roomId"):rs.getString("changeRoom"));
                s.setGroupId(rs.getString("groupId"));
                IDate d = new IDate(rs.getDate("date"));
                s.setDate(d);
                s.setSlotId(rs.getInt("changeSlot")==0?rs.getInt("slotId"):rs.getInt("changeSlot"));
                s.setStatus(rs.getBoolean("status"));
                schedules.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return schedules;
    }
    
    public ArrayList<Schedule> getScheduleLecturer(String lecturerId, String fromDate, String toDate) {
        ArrayList<Schedule> schedules = new ArrayList<>();
        String sql = """
                     select distinct l.lecturerId, l.subjectId, s.roomId, l.groupId, s.slotId, i.date, i.status, i.changeLecturer, i.changeRoom, i.changeSlot
                     from isTaken i
                     join Lession l on i.lecturerId = l.lecturerId and i.groupId = l.groupId and i.subjectId = l.subjectId
                     join Schedule s on s.groupId = l.groupId and s.subjectId = l.subjectId and i.slotId = s.slotId
                     where ((i.lecturerId = ? and i.changeLecturer is null) or i.changeLecturer = ?) 
                     and i.[date] >= ? and [date] <= ?
                     order by i.[date]
                     """;

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lecturerId);
            stm.setString(2, lecturerId);
            stm.setString(3, fromDate);
            stm.setString(4, toDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Schedule s = new Schedule();
                if (rs.getString("changeLecturer") == null) {
                    s.setId(rs.getString("lecturerId"));
                } else {
                    s.setId(rs.getString("changeLecturer"));
                }
                s.setSubjectId(rs.getString("subjectId"));
                s.setRoomId(rs.getString("changeRoom")==null?rs.getString("roomId"):rs.getString("changeRoom"));
                s.setGroupId(rs.getString("groupId"));
                IDate d = new IDate(rs.getDate("date"));
                s.setDate(d);
                s.setSlotId(rs.getInt("changeSlot")==0?rs.getInt("slotId"):rs.getInt("changeSlot"));
                s.setStatus(rs.getBoolean("status"));
                schedules.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return schedules;
    }

    public ArrayList<Schedule> getScheduleByDate(String id, String date) {
        ArrayList<Schedule> schedules = new ArrayList<>();
        String sql = """
                     select distinct i.lecturerId, i.groupId, l.subjectId, i.slotId, i.date, i.changeLecturer, s.name, sche.roomId, i.status, i.changeRoom, i.changeSlot
                     from isTaken i
                     join Lession l on l.groupId = i.groupId and l.lecturerId = i.lecturerId and i.subjectId = l.subjectId
                     join Schedule sche on sche.groupId = i.groupId and sche.subjectId = l.subjectId and i.slotId = sche.slotId
                     join Subject s on sche.subjectId = s.id
                     where ((i.lecturerId = ? and i.changeLecturer is null) or i.changeLecturer = ?)
                     and date = ?
                     order by i.slotId
                     """;

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setString(2, id);
            stm.setString(3, date);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Schedule s = new Schedule();
                if (rs.getString("changeLecturer") == null) {
                    s.setId(rs.getString("lecturerId"));
                } else {
                    s.setId(rs.getString("changeLecturer"));
                }
                s.setSlotId(rs.getInt("changeSlot")==0?rs.getInt("slotId"):rs.getInt("changeSlot"));
                s.setSubjectId(rs.getString("subjectId"));
                s.setSubjectName(rs.getString("name"));
                s.setGroupId(rs.getString("groupId"));
                s.setRoomId(rs.getString("changeRoom")==null?rs.getString("roomId"):rs.getString("changeRoom"));
                s.setStatus(rs.getBoolean("status"));
                Date d = rs.getDate("date");
                IDate d2 = new IDate(d);
                s.setDate(d2);
                schedules.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return schedules;
    }

    public void changeLecturer(String id, String groupId, int slotId, String date, String newId) {
        String sql = """
                     update isTaken set changeLecturer = ?
                     where (lecturerId = ? or changeLecturer = ?) and groupId = ? and date = ? and slotId = ?
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, newId);
            stm.setString(2, id);
            stm.setString(3, id);
            stm.setString(4, groupId);
            stm.setString(5, date);
            stm.setInt(6, slotId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    public void changeSession(String lecturerId, String fromDate, int fromSlotId, String toDate, int toSlotId, String toRoomId){
        String sql = """
                     update isTaken set [date] = ?, changeRoom = ?, changeSlot = ?
                     where lecturerId = ? and [date] = ? and ((slotId = ? and changeSlot is null) or changeSlot = ?)
                     """;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, toDate);
            stm.setString(2, toRoomId);
            stm.setInt(3, toSlotId);
            stm.setString(4, lecturerId);
            stm.setString(5, fromDate);
            stm.setInt(6, fromSlotId);
            stm.setInt(7, fromSlotId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LecturerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    public static void main(String[] args) {
        LecturerDBContext lecDB = new LecturerDBContext();
        ArrayList<Schedule> schedules = lecDB.getScheduleLecturer("SonNT5", 10, 2024);
        
    }

}
