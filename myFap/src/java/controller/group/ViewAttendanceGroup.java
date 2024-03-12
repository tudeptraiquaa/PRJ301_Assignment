/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.group;

import controller.authentication.BaseRequireAuthentication;
import dal.GroupDBContext;
import entity.Account;
import entity.Attendance;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class ViewAttendanceGroup extends BaseRequireAuthentication {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
    throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        String lecturerId = request.getParameter("id");
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        String date = request.getParameter("date");
        String slotId = request.getParameter("slotId");
        ArrayList<Attendance> attendances = gDB.viewAttendanceGroup(groupId, subjectId, date, Integer.parseInt(slotId));
        String adminId = request.getParameter("adminId");
        
        request.setAttribute("adminId", adminId);
        request.setAttribute("id", lecturerId);
        request.setAttribute("groupId", groupId);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("date", date);
        request.setAttribute("slotId", slotId);
        request.setAttribute("attendances", attendances);
        request.getRequestDispatcher("../../view/group/viewAttendance.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account a)
    throws ServletException, IOException {
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
