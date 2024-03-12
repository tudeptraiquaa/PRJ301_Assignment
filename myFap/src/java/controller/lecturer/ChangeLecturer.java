/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lecturer;

import controller.authentication.BaseRequireAuthentication;
import dal.LecturerDBContext;
import entity.Account;
import entity.Lecturer;
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
public class ChangeLecturer extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        String slotId = request.getParameter("slotId");
        String date = request.getParameter("date");

        request.setAttribute("id", id);
        request.setAttribute("groupId", groupId);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("slotId", slotId);
        request.setAttribute("date", date);

        request.getRequestDispatcher("../view/lecturer/change.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        LecturerDBContext lecDB = new LecturerDBContext();
        String id = request.getParameter("id");
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        String slotId = request.getParameter("slotId");
        String date = request.getParameter("date");
        request.setAttribute("id", id);
        request.setAttribute("groupId", groupId);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("slotId", slotId);
        request.setAttribute("date", date);
        String newId = request.getParameter("newId");
        Lecturer lec = lecDB.getInformation(newId);
        if (lec == null) {
            request.setAttribute("error", "Lecturer ID dose not exists!");
            request.getRequestDispatcher("../view/lecturer/change.jsp").forward(request, response);
        }
        ArrayList<Schedule> schedules = lecDB.getScheduleByDate(newId, date);
        boolean check = true;
        for (Schedule s : schedules) {
            if (s.getSlotId() == Integer.parseInt(slotId)) {
                check = false;
                break;
            }
        }
        if (check) {
            lecDB.changeLecturer(id, groupId, Integer.parseInt(slotId), date, newId);
            request.getRequestDispatcher("../view/home/setSuccess.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Teachers have the same teaching slot!");
            request.getRequestDispatcher("../view/lecturer/change.jsp").forward(request, response);
        }
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
