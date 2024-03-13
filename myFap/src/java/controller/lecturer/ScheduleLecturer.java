/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lecturer;

import controller.authentication.BaseRequireAuthentication;
import dal.LecturerDBContext;
import entity.Account;
import entity.IDate;
import entity.IWeek;
import entity.Lecturer;
import entity.Schedule;
import entity.Slot;
import functiton.MyDate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.Locale;

/**
 *
 * @author tu
 */
public class ScheduleLecturer extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        LecturerDBContext lecDB = new LecturerDBContext();
        MyDate myDate = new MyDate();
        String lecturerId = request.getParameter("id");
        if (lecturerId != null) {
            ArrayList<Integer> years = lecDB.getScheduleYear(lecturerId);
            if (!years.isEmpty()) {
                int minYear = years.get(0);
                int maxYear = years.get(years.size() - 1);
                request.setAttribute("minYear", minYear);
                request.setAttribute("maxYear", maxYear);
                request.setAttribute("years", years);
            }
        }
        String option = request.getParameter("option");
        if (option == null) {
            option = "0";
        }
        LocalDate currentDate = LocalDate.now();
        int year, currentYear, week;
        String y = request.getParameter("year");
        if (y == null) {
            year = currentDate.getYear();
        } else {
            year = Integer.parseInt(y.trim());
        }
        currentYear = currentDate.getYear();

        // lay danh sach tuan theo nam
        ArrayList<IWeek> weeks = myDate.getWeekInYear(year);

        // ngay hien tai
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String currentDay = currentDate.format(formatter);

        // lay tuan
        String w = request.getParameter("week");
        if (w == null) {
            WeekFields weekFields = WeekFields.of(Locale.getDefault());
            week = currentDate.get(weekFields.weekOfWeekBasedYear());
        } else {
            week = Integer.parseInt(w.trim());
        }
        request.setAttribute("week", week);

        // lay ngay cua mot tuan trong nam
        IWeek iWeek = myDate.getWeek(week, year);

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        if (option.equals("1")) {
            if (fromDate == null && toDate == null) {
                fromDate = iWeek.getFromDate().toString();
                toDate = iWeek.getToDate().toString();
            }
            request.setAttribute("fromDate", fromDate);
            request.setAttribute("toDate", toDate);
        }

        int month = Integer.parseInt(iWeek.getFromDate().getMonth());
        String termId;
        if (month >= 1 && month <= 4) {
            termId = "SP";
        } else if (month >= 5 && month <= 8) {
            termId = "SU";
        } else {
            termId = "FA";
        }
        request.setAttribute("termId", termId);

        ArrayList<Slot> slots = lecDB.getSlot();
        ArrayList<IDate> dates = new ArrayList<>();
        ArrayList<Schedule> schedules = new ArrayList<>();

        if (option.equals("0")) {
            dates = iWeek.getDateInWeek();
            schedules = lecDB.getScheduleLecturer(lecturerId, week, year);
        }
        if (option.equals("1")) {
            IDate from = new IDate(fromDate);
            IDate to = new IDate(toDate);
            dates = myDate.getRangeDate(from, to);
            schedules = lecDB.getScheduleLecturer(lecturerId, fromDate, toDate);
        }

        if (lecturerId != null) {
            Lecturer lecturer = lecDB.getInformation(lecturerId);
            if (lecturer == null) {
                request.setAttribute("error", "Lecturer id does not exists!");
            }
        }

        request.setAttribute("option", option);
        request.setAttribute("schedules", schedules);
        request.setAttribute("currentYear", currentYear);
        request.setAttribute("dates", dates);
        request.setAttribute("slots", slots);
        request.setAttribute("currentDay", currentDay);
        request.setAttribute("weeks", weeks);
        request.setAttribute("year", year);
        request.setAttribute("id", lecturerId);

        request.getRequestDispatcher("../view/lecturer/schedule.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
