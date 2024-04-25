/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.group;

import controller.authentication.BaseRequireAuthentication;
import dal.GroupDBContext;
import entity.Account;
import entity.IDate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class AddScheduleGroup extends BaseRequireAuthentication {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
    throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        ArrayList<String> gsId = gDB.getListGroup();
        String groupId = gsId.get(0);
        ArrayList<String> subjectsId = gDB.getSubjectGroupNotYet(groupId);
        IDate now = new IDate();
        String year = now.getYear();
        ArrayList<String> termsId = gDB.getTermGroup(Integer.parseInt(year));
        String[] weekdays = {"2","3","4","5","6","7","CN"};
        int weekday = Integer.parseInt(weekdays[0]);
        ArrayList<Integer> slotsId = gDB.getSLotsIdNotYetByWeekDay(groupId, weekday, termsId.get(0), Integer.parseInt(year));
        
        request.setAttribute("slotsId", slotsId);
        request.setAttribute("weekdays", weekdays);
        request.setAttribute("termsId", termsId);
        request.setAttribute("now", now);
        request.setAttribute("groupId", groupId);
        request.setAttribute("subjectsId", subjectsId);
        request.setAttribute("groupsId", gsId);
        request.getRequestDispatcher("../view/group/addSchedule.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account a)
    throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        ArrayList<String> gsId = gDB.getListGroup();
        
        String groupId = request.getParameter("groupId");
        ArrayList<String> subjectsId = gDB.getSubjectGroupNotYet(groupId);
        
        String subjectId = request.getParameter("subjectId");
        IDate now = new IDate();
        String year = request.getParameter("year");
        ArrayList<String> termsId = gDB.getTermGroup(Integer.parseInt(year));
        String termId = request.getParameter("termId");
        String[] weekdays = {"2","3","4","5","6","7","CN"};
        String weekday = request.getParameter("weekday").equals("CN")?"8":request.getParameter("weekday");
        
        ArrayList<Integer> slotsId = gDB.getSLotsIdNotYetByWeekDay(groupId, Integer.parseInt(weekday), termId, Integer.parseInt(year));
        String slotId = request.getParameter("slotId");
        
        request.setAttribute("slotId", slotId);
        request.setAttribute("slotsId", slotsId);
        request.setAttribute("weekday", weekday);
        request.setAttribute("weekdays", weekdays);
        request.setAttribute("termId", termId);
        request.setAttribute("termsId", termsId);
        request.setAttribute("year", year);
        request.setAttribute("now", now);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("subjectsId", subjectsId);
        request.setAttribute("groupId", groupId);
        request.setAttribute("groupsId", gsId);
        request.getRequestDispatcher("../view/group/addSchedule.jsp").forward(request, response);
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
