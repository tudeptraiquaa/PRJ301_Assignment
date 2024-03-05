/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package functiton;

import dal.DBContext;
import entity.Holiday;
import entity.IDate;
import entity.IEntity;
import entity.IWeek;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tu
 */
public class MyDate extends DBContext<IEntity> {

    public ArrayList<IDate> getDateInYear(int year) {
        ArrayList<IDate> dates = new ArrayList();
        int stop = year + 1;
        int day = 1;
        int month = 1;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat format2 = new SimpleDateFormat("dd MM yyyy EEE");
        format.setLenient(false);
        String[] d = {"", "", "", ""};
        while (year < stop || !d[3].equalsIgnoreCase("Mon")) {
            try {
                Date date = format.parse(year + "-" + month + "-" + day);
                d = format2.format(date).split(" ");
                IDate idate = new IDate();
                idate.setDay(d[0]);
                idate.setMonth(d[1]);
                idate.setYear(d[2]);
                idate.setWeekday(d[3]);
                dates.add(idate);
                day += 1;
            } catch (ParseException e) {
                if (month < 12) {
                    month += 1;
                    day = 1;
                } else {
                    year += 1;
                    month = 1;
                    day = 1;
                }
            }
        }
        while (!dates.get(0).getWeekday().equalsIgnoreCase("Mon")) {
            dates.remove(0);
        }
        return dates;
    }

    public IWeek getWeek(int week, int year) {
        MyDate myDate = new MyDate();
        ArrayList<IDate> iDates = myDate.getDateInYear(year);
        ArrayList<IDate> dateInWeek = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            dateInWeek.add(iDates.get(i + (week - 1) * 7));
        }
        IWeek iWeek = new IWeek();
        iWeek.setDateInWeek(dateInWeek);
        iWeek.setFromDate(dateInWeek.get(0));
        iWeek.setToDate(dateInWeek.get(6));
        return iWeek;
    }

    public ArrayList<IWeek> getWeekInYear(int year) {
        ArrayList<IWeek> getWeekInYear = new ArrayList<>();
        MyDate m = new MyDate();
        for (int i = 1; i <= 52; i++) {
            IWeek iWeek = m.getWeek(i, year);
            getWeekInYear.add(iWeek);
        }
        return getWeekInYear;
    }

    public ArrayList<Holiday> getHolidays(int year) {
        String sql = "select [from], [to] from Holiday where year([from]) = ?";
        ArrayList<Holiday> holidays = new ArrayList<>();
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, year);
            ResultSet rs = stm.executeQuery();
            SimpleDateFormat format = new SimpleDateFormat("dd MM yyyy EEE");
            while (rs.next()) {
                Holiday h = new Holiday();
                String[] d1 = format.format(rs.getDate("from")).split(" ");
                String[] d2 = format.format(rs.getDate("to")).split(" ");
                IDate from = new IDate(d1[0], d1[1], d1[2], d1[3]);
                IDate to = new IDate(d2[0], d2[1], d2[2], d2[3]);
                h.setFromDate(from);
                h.setToDate(to);
                holidays.add(h);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MyDate.class.getName()).log(Level.SEVERE, null, ex);
        }

        return holidays;
    }

    public ArrayList<IDate> getDateInTerm(String termId, int year) {
        ArrayList<IDate> dateInTerm = new ArrayList<>();
        int monthBegin = 0;
        int monthEnd = 0;
        int stop = year + 1;
        switch (termId) {
            case "SP" -> {
                monthBegin = 1;
                monthEnd = 4;
            }
            case "SU" -> {
                monthBegin = 5;
                monthEnd = 8;
            }
            case "FA" -> {
                monthBegin = 9;
                monthEnd = 12;
            }
        }

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat format2 = new SimpleDateFormat("dd MM yyyy EEE");
        format.setLenient(false);
        String[] d = {"", "", "", ""};
        int day = 1;
        while ((monthBegin <= monthEnd && year < stop) || !d[3].equalsIgnoreCase("Mon")) {
            try {
                Date date = format.parse(year + "-" + monthBegin + "-" + day);
                d = format2.format(date).split(" ");
                IDate idate = new IDate();
                idate.setDay(d[0]);
                idate.setMonth(d[1]);
                idate.setYear(d[2]);
                idate.setWeekday(d[3]);
                dateInTerm.add(idate);
                day += 1;
            } catch (ParseException e) {
                if (monthBegin < 12) {
                    monthBegin += 1;
                    day = 1;
                } else {
                    year += 1;
                    monthBegin = 1;
                    day = 1;
                }
            }
        }
        while (!dateInTerm.get(0).getWeekday().equalsIgnoreCase("Mon")) {
            dateInTerm.remove(0);
        }

        return dateInTerm;
    }

    public ArrayList<IDate> getRangeDate(IDate from, IDate to) {
        ArrayList<IDate> dates = new ArrayList<>();
        int sDate = Integer.parseInt(from.getDay());
        int sMonth = Integer.parseInt(from.getMonth());
        int sYear = Integer.parseInt(from.getYear());

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat format2 = new SimpleDateFormat("dd MM yyyy EEE");
        format.setLenient(false);
        String[] d = {"", "", "", ""};
        while (from.compare(to) < 0) {
            try {
                Date date = format.parse(sYear + "-" + sMonth + "-" + sDate);
                d = format2.format(date).split(" ");
                IDate idate = new IDate();
                idate.setDay(d[0]);
                idate.setMonth(d[1]);
                idate.setYear(d[2]);
                idate.setWeekday(d[3]);
                from.setDay(d[0]);
                from.setMonth(d[1]);
                from.setYear(d[2]);
                dates.add(idate);
                sDate += 1;
            } catch (ParseException e) {
                if (sMonth < 12) {
                    sMonth += 1;
                    sDate = 1;
                } else {
                    sYear += 1;
                    sMonth = 1;
                    sDate = 1;
                }
            }
        }

        return dates;
    }
    
    public static void main(String[] args) {
        MyDate m = new MyDate();
        ArrayList<IDate> dates = m.getDateInTerm("SU", 2024);
        for(IDate d : dates){
            System.out.println(d);
        }
    }

}
