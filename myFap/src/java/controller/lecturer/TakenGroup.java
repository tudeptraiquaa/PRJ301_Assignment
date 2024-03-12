/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.lecturer;

import controller.authentication.BaseRequireAuthentication;
import dal.LecturerDBContext;
import entity.Account;
import entity.Schedule;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class TakenGroup extends BaseRequireAuthentication {
   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
    throws ServletException, IOException {
        LecturerDBContext lecDB = new LecturerDBContext();
        String id = request.getParameter("id");
        String date = request.getParameter("date");
        ArrayList<Schedule> schedules = lecDB.getScheduleByDate(id, date);
        
        request.setAttribute("date", date);
        request.setAttribute("schedules", schedules);
        request.getRequestDispatcher("../view/lecturer/takenGroup.jsp").forward(request, response);
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
