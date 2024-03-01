/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import dal.GroupDBContext;
import dal.StudentDBContext;
import entity.Account;
import entity.Attendance;
import entity.IDate;
import entity.Student;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class EditAttendanceGroup extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        String id = request.getParameter("id");
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        String date = request.getParameter("date");
        String slotId = request.getParameter("slotId");
        String adminId = request.getParameter("adminId");

        
        request.setAttribute("adminId", adminId);

        ArrayList<Attendance> attendances = gDB.viewAttendanceGroup(groupId, subjectId, date, Integer.parseInt(slotId));
        request.setAttribute("id", id);
        request.setAttribute("groupId", groupId);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("date", date);
        request.setAttribute("slotId", slotId);
        request.setAttribute("attendances", attendances);
        request.getRequestDispatcher("../../view/group/editAttendance.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();

        String id = request.getParameter("id");
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        String date = request.getParameter("date");
        String slotId = request.getParameter("slotId");
        String week = request.getParameter("week");
        String year = request.getParameter("year");
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        StudentDBContext stuDB = new StudentDBContext();
        ArrayList<Student> students = stuDB.getStudentGroupBySubject(groupId, subjectId);

        String[] studentsId = request.getParameterValues("studentId");
        ArrayList<Attendance> newA = new ArrayList<>();
        Timestamp timeRecord = new Timestamp(System.currentTimeMillis());
        for (String studentId : studentsId) {

            boolean status = request.getParameter(studentId + "status").equals("1");
            String description = request.getParameter(studentId + "description");

            Attendance a = new Attendance();
            a.setStudentId(studentId);
            a.setSubjectId(subjectId);
            a.setGroupId(groupId);
            a.setStatus(status);
            if (description == null) {
                a.setDescription(" ");
            } else {
                a.setDescription(description.trim());
            }
            a.setTimeRecord(timeRecord);
            a.setTaker(acc.getUser());
            a.setDate(new IDate(date));
            a.setSlotId(Integer.parseInt(slotId.trim()));
            newA.add(a);
        }

        ArrayList<Attendance> oldA = gDB.viewAttendanceGroup(groupId, subjectId, date, Integer.parseInt(slotId.trim()));
        boolean isTaken = gDB.groupIsTaken(groupId, subjectId, date);
        if (!isTaken) {
            gDB.isTakenGroup(id, groupId, date, slotId, timeRecord);
        }
        gDB.editAttendance(oldA, newA, isTaken);
        
        request.setAttribute("year", year);
        request.setAttribute("week", week);
        request.setAttribute("slotId", slotId);
        request.setAttribute("id", id);
        request.setAttribute("groupId", groupId);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("date", date);
        request.setAttribute("students", students);
        oldA = gDB.viewAttendanceGroup(groupId, subjectId, date, Integer.parseInt(slotId.trim()));
        request.setAttribute("attendances", oldA);
        request.getRequestDispatcher("../../view/home/changeSuccess.jsp").forward(request, response);

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
