/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ajax.lecturer;

import dal.LecturerDBContext;
import entity.IDate;
import entity.IWeek;
import entity.Lecturer;
import entity.Schedule;
import entity.Slot;
import functiton.MyDate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
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
public class TableWeekScheduleLecturerAjax extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LecturerDBContext lecDB = new LecturerDBContext();
        MyDate myDate = new MyDate();
        String lecturerId = request.getParameter("id");
        ArrayList<Integer> years = lecDB.getScheduleYear(lecturerId);
        int minYear = years.get(0);
        int maxYear = years.get(years.size() - 1);
        request.setAttribute("minYear", minYear);
        request.setAttribute("maxYear", maxYear);
        request.setAttribute("years", years);
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
        request.getRequestDispatcher("../../../../ajax/lecturer/scheduleTableWeek.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
