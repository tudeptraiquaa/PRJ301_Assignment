/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lecturer;

import controller.authentication.BaseRequireAuthentication;
import dal.LecturerDBContext;
import dal.StudentDBContext;
import entity.Account;
import entity.IDate;
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
public class ChangeSessionLecturer extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        StudentDBContext stuDB = new StudentDBContext();
        Schedule s = new Schedule();
        String lecturerId = request.getParameter("lecturerId");
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        s.setLecturerId(lecturerId);
        s.setGroupId(groupId);
        s.setSubjectId(subjectId);
        String fromDate = request.getParameter("fromDate");
        if (fromDate != null) {
            s.setDate(new IDate(request.getParameter("fromDate")));
        }
        s.setSlotId(Integer.parseInt(request.getParameter("fromSlotId")));
        s.setRoomId(request.getParameter("fromRoomId"));
        String toDate = request.getParameter("toDate") == null ? request.getParameter("fromDate") : request.getParameter("toDate");
        ArrayList<Integer> slots = stuDB.getSlotStudentFromClass(groupId, subjectId, toDate);
        if (slots.size() != 0) {
            request.setAttribute("slots", slots);
        }
        String toSlotId = request.getParameter("toSlotId");
        if (toSlotId != null) {
            request.setAttribute("toSlotId", toSlotId);
            ArrayList<String> roomsId = stuDB.getRoomIdEmpty(toDate, Integer.parseInt(toSlotId));
            if (roomsId.size() != 0) {
                request.setAttribute("rooms", roomsId);
            }
        }

        String toRoomId = request.getParameter("toRoomId");
        if (toRoomId != null) {
            request.setAttribute("toRoomId", toRoomId);
        }
        IDate now = new IDate();
        
        request.setAttribute("now", now);
        request.setAttribute("toDate", toDate);
        request.setAttribute("schedule", s);
        request.getRequestDispatcher("../view/lecturer/changeSession.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        String lecturerId = request.getParameter("lecturerId");
        int fromSlotId = Integer.parseInt(request.getParameter("fromSlotId"));
        String fromDate = request.getParameter("fromDate");
        int toSlotId = Integer.parseInt(request.getParameter("toSlotId"));
        String toDate = request.getParameter("toDate");
        String toRoomId = request.getParameter("toRoomId");

        LecturerDBContext lecDB = new LecturerDBContext();
        lecDB.changeSession(lecturerId, fromDate, fromSlotId, toDate, toSlotId, toRoomId);
        request.setAttribute("set", "Change success");
        request.getRequestDispatcher("../view/home/setSuccess.jsp").forward(request, response);
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
