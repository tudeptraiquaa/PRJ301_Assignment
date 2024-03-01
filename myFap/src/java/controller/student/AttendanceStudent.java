/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import dal.GroupDBContext;
import dal.StudentDBContext;
import entity.Attendance;
import entity.IDate;
import entity.Subject;
import entity.Term;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class AttendanceStudent extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        
        String id = request.getParameter("id");
        request.setAttribute("id", id);

        StudentDBContext stuDB = new StudentDBContext();
        ArrayList<Term> terms = stuDB.getTermStudent(id);
        request.setAttribute("terms", terms);

        String termId = request.getParameter("termId");
        String y = request.getParameter("year");
        if (termId != null && y != null) {
            int year = Integer.parseInt(y);
            ArrayList<Subject> subjects = stuDB.getSubjectStudent(id, termId, year);
            request.setAttribute("subjects", subjects);
            request.setAttribute("year", year);
            request.setAttribute("termId", termId.trim());
        } else {
            String d = request.getParameter("date");
            IDate date = new IDate(d);
            int month = Integer.parseInt(date.getMonth());
            if (month >= 1 && month <= 4) {
                termId = "SP";
            } else if (month >= 5 && month <= 8) {
                termId = "SU";
            } else {
                termId = "FA";
            }
            int year = Integer.parseInt(date.getYear());
            ArrayList<Subject> subjects = stuDB.getSubjectStudent(id, termId, year);
            request.setAttribute("subjects", subjects);
            request.setAttribute("year", year);
            request.setAttribute("termId", termId.trim());
        }

        String subId = request.getParameter("subjectId");
        if (subId != null) {
            ArrayList<Attendance> attendances = stuDB.getAttendanceStudent(id, subId, termId, Integer.parseInt(y));
            request.setAttribute("attendances", attendances);
            request.setAttribute("subjectId", subId);
        }
        
        
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        IDate now = new IDate (currentDate.format(formatter));
        
        request.setAttribute("now", now);

        request.getRequestDispatcher("../view/student/attendance.jsp").forward(request, response);
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
