/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import controller.authentication.BaseRequireAuthentication;
import dal.GroupDBContext;
import entity.Account;
import entity.RequireChangeGroup;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class ChangeGroupProcess extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        String status = request.getParameter("status");
        Timestamp timeRecord = new Timestamp(System.currentTimeMillis());
        gDB.processRequires(status, timeRecord);
        ArrayList<RequireChangeGroup> processing = gDB.getRequiresChangeGroup();
        if (processing.size() == 0) {
            request.setAttribute("request", "All requests have been processed");
            request.getRequestDispatcher("../../view/group/viewRequireChange.jsp").forward(request, response);
        } else {
            request.setAttribute("processing", processing);
            request.getRequestDispatcher("../../view/group/viewRequireChange.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        Timestamp timeRecord = new Timestamp(System.currentTimeMillis());
        RequireChangeGroup r = new RequireChangeGroup();
        r.setIdFrom(request.getParameter("id"));
        r.setSubjectId(request.getParameter("subjectId"));
        r.setGroupIdFrom(request.getParameter("groupIdFrom"));
        r.setIdTo(request.getParameter("idTo"));
        r.setGroupIdTo(request.getParameter("groupIdTo"));
        r.setComment(request.getParameter("comment"));
        r.setStatus(request.getParameter("status").equalsIgnoreCase("Reject") ? "0" : "1");
        r.setDateProcessing(timeRecord);
        boolean status = gDB.processRequireStudent(r);
        request.setAttribute("status", status);
                
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        ArrayList<RequireChangeGroup> processing = gDB.getRequiresChangeGroup();
        if (processing.size() == 0) {
            request.setAttribute("request", "All requests have been processed");
            request.getRequestDispatcher("../../view/group/viewRequireChange.jsp").forward(request, response);
        } else {
            request.setAttribute("processing", processing);
            request.getRequestDispatcher("../../view/group/viewRequireChange.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
