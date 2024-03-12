/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import controller.authentication.BaseRequireAuthentication;
import dal.GroupDBContext;
import dal.StudentDBContext;
import entity.Account;
import entity.Attendance;
import entity.IDate;
import entity.Student;
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
public class AttendanceGroup extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        String lecturerId = request.getParameter("id");
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        String date = request.getParameter("date");
        String slotId = request.getParameter("slotId");
        
        StudentDBContext stuDB = new StudentDBContext();
        ArrayList<Student> students = stuDB.getStudentGroupBySubject(groupId, subjectId);

        request.setAttribute("slotId", slotId);
        request.setAttribute("lecturerId", lecturerId);
        request.setAttribute("groupId", groupId);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("date", date);
        request.setAttribute("students", students);
        request.getRequestDispatcher("../view/group/attendance.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account ac)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();

        String lecturerId = request.getParameter("lecturerId");
        String groupId = request.getParameter("groupId");
        String subjectId = request.getParameter("subjectId");
        String date = request.getParameter("date");
        String slotId = request.getParameter("slotId");

        String[] studentsId = request.getParameterValues("id");
        ArrayList<Attendance> attendances = new ArrayList<>();
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
            a.setTaker(lecturerId);
            a.setDate(new IDate(date));
            a.setSlotId(Integer.parseInt(slotId));
            attendances.add(a);
        }

        gDB.attendance(attendances);
        gDB.isTakenGroup(lecturerId, groupId, date, slotId, timeRecord);

        request.setAttribute("set", "Attendance successfully");
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
