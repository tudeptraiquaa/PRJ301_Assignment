/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import dal.GroupDBContext;
import dal.StudentDBContext;
import entity.IDate;
import entity.Student;
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
public class StudentGroup extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        StudentDBContext stuDB = new StudentDBContext();
        
        ArrayList<Term> termGroup = gDB.getTermGroup();
        ArrayList<String> groupsId, subjectsId;
        
        String termId = request.getParameter("termId");
        String year = request.getParameter("year");
        
        if(termId != null && year != null){
            groupsId = gDB.getGroupByTerm(termId, Integer.parseInt(year.trim()));
            
            request.setAttribute("year", year);
            request.setAttribute("groupsId", groupsId);
            request.setAttribute("termId", termId);
        }
        String groupId = request.getParameter("groupId");
        
        if (groupId != null) {
            
            subjectsId = gDB.getSubjectGroupByTerm(groupId, termId, year);
            request.setAttribute("subjectsId", subjectsId);
            request.setAttribute("groupId", groupId);
        }
        
        String subjectId = request.getParameter("subjectId");
        if(subjectId != null){
            ArrayList<Student> students = stuDB.getStudentGroupBySubject(groupId, subjectId);
            request.setAttribute("students", students);
            request.setAttribute("subjectId", subjectId);
        }
        
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        IDate now = new IDate (currentDate.format(formatter));
        
        request.setAttribute("now", now);
        
        String id = request.getParameter("id");        
        request.setAttribute("id", id);
        request.setAttribute("termGroup", termGroup);
        request.getRequestDispatcher("../view/group/student.jsp").forward(request, response);

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
