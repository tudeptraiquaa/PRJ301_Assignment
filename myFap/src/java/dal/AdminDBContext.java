/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Calendar;
import entity.Holiday;
import entity.IDate;
import entity.Lession;
import entity.Schedule;
import functiton.MyDate;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tu
 */
public class AdminDBContext extends DBContext {

    public ArrayList<Lession> getLession() {
        ArrayList<Lession> lessions = new ArrayList<>();
        String sql = """
                     select distinct le.lecturerId, le.groupId, le.subjectId, le.numLession, sche.termId, sche.year, sche.roomId
                     from Lession le
                     join Schedule sche on le.groupId = sche.groupId and le.subjectId = sche.subjectId""";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lession l = new Lession();
                l.setLecturerId(rs.getString("lecturerId"));
                l.setGroupId(rs.getString("groupId"));
                l.setSubjectId(rs.getString("subjectId"));
                l.setNumLession(rs.getInt("numLession"));
                l.setTermId(rs.getString("termId"));
                l.setYear(rs.getInt("year"));
                l.setRoomId(rs.getString("roomId"));
                lessions.add(l);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lessions;
    }

    public void setSchedule() {
        MyDate myDate = new MyDate();
        AdminDBContext adDB = new AdminDBContext();
        ArrayList<Lession> lessions = adDB.getLession();
        ArrayList<Schedule> schedules = new ArrayList<>();
        
        try {
            String delete = "Delete from isTaken";
            PreparedStatement s = connection.prepareStatement(delete);
            s.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        for (Lession l : lessions) {
            ArrayList<IDate> dateInTerm = myDate.getDateInTerm(l.getTermId(), l.getYear());
            ArrayList<Holiday> holidays = myDate.getHolidays(l.getYear());
            ArrayList<Calendar> calendars = new ArrayList<>();
            String sql = """
                         select slotId, [weekday] from Schedule s
                         where groupId = ? and subjectId = ? 
                         """;
            try {
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, l.getGroupId());
                stm.setString(2, l.getSubjectId());
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Calendar c = new Calendar();
                    c.setSlotId(rs.getInt("slotId"));
                    c.setWeekday(rs.getInt("weekday"));
                    calendars.add(c);
                }
            } catch (SQLException ex) {
                Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }

            int count = 1;
            for (IDate d : dateInTerm) {
                Calendar c = checkDate(d, holidays, calendars);
                if (c != null) {
                    Schedule s = new Schedule();
                    s.setId(l.getLecturerId());
                    s.setSubjectId(l.getSubjectId());
                    s.setGroupId(l.getGroupId());
                    s.setRoomId(l.getRoomId());
                    s.setSlotId(c.getSlotId());
                    s.setDate(d);
                    schedules.add(s);
                    if (count == l.getNumLession()) {
                        break;
                    }
                    count++;
                }
            }
        }
        for (Schedule s : schedules) {
            String sql = """
                         insert into isTaken (lecturerId, groupId, slotId, [date]) values (?, ?, ?, ?)
                         """;
            try {
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, s.getId());
                stm.setString(2, s.getGroupId());
                stm.setInt(3, s.getSlotId());
                stm.setString(4, s.getDate().toString());
                stm.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    public Calendar checkDate(IDate date, ArrayList<Holiday> holidays, ArrayList<Calendar> calendars) {
        for (Holiday h : holidays) {
            if (date.toInt() >= h.getFromDate().toInt() && date.toInt() <= h.getToDate().toInt()) {
                return null;
            }
        }

        for (Calendar c : calendars) {
            if (date.getIntWeekday() == c.getWeekday()) {
                return c;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        AdminDBContext adDB = new AdminDBContext();

        adDB.setSchedule();

    }
}
