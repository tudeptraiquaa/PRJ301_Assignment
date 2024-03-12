/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import controller.authentication.BaseRequireAuthentication;
import dal.StudentDBContext;
import entity.Account;
import entity.Attendance;
import entity.IDate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author tu
 */
public class ActivityGroup extends BaseRequireAuthentication{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String d = request.getParameter("date");
        IDate date = new IDate(d);
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        String termId = request.getParameter("termId");
        String year = request.getParameter("year");
        String slotId = request.getParameter("slotId");
        StudentDBContext stuDB = new StudentDBContext();
        Attendance attendance = stuDB.getSchedule(id, groupId, subjectId, d);
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        IDate now = new IDate(currentDate.format(formatter));
        
        request.setAttribute("attendance", attendance);
        request.setAttribute("now", now);
        request.setAttribute("slotId", slotId);
        request.setAttribute("id", id);
        request.setAttribute("date", date);
        request.setAttribute("groupId", groupId);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("termId", termId);
        request.setAttribute("year", year);
        request.getRequestDispatcher("../view/group/activity.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
