/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import dal.StudentDBContext;
import entity.IDate;
import entity.Student;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.WeekFields;
import java.util.Locale;

/**
 *
 * @author tu
 */
public class InformationStudent extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = request.getParameter("id");
        StudentDBContext stuDB = new StudentDBContext();

        LocalDate currentDate = LocalDate.now();
        int year = currentDate.getYear();
        WeekFields weekFields = WeekFields.of(Locale.getDefault());
        int week = currentDate.get(weekFields.weekOfWeekBasedYear());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        IDate now = new IDate(currentDate.format(formatter));

        request.setAttribute("now", now);
        request.setAttribute("week", week);
        request.setAttribute("year", year);
        if (studentId != null) {
            Student s = stuDB.getInformation(studentId);
            if (s == null) {
                request.setAttribute("error", "Student id does not exists!");
            } else {
                request.setAttribute("student", s);
            }
        }
        request.getRequestDispatcher("../view/student/information.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
