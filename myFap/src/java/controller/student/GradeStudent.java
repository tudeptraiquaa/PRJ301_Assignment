/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import controller.authentication.BaseRequireAuthentication;
import dal.StudentDBContext;
import entity.Account;
import entity.Assessment;
import entity.Grade;
import entity.IDate;
import entity.Score;
import entity.Subject;
import entity.Term;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class GradeStudent extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        request.setAttribute("id", id);

        StudentDBContext stuDB = new StudentDBContext();
        ArrayList<Term> terms = stuDB.getTermStudent(id);

        String termId = request.getParameter("termId");
        String y = request.getParameter("year");
        ArrayList<Subject> subjects = null;
        if (termId != null && y != null) {
            int year = Integer.parseInt(y);
            subjects = stuDB.getSubjectStudent(id, termId, year);
            request.setAttribute("subjects", subjects);
            request.setAttribute("year", year);
            request.setAttribute("termId", termId.trim());
        }
        String subId = request.getParameter("subjectId");
        if (subId != null) {
            for (Subject s : subjects) {
                if (subId.trim().equalsIgnoreCase(s.getId())) {
                    request.setAttribute("dateBegin", s.getDateBegin());
                    request.setAttribute("dateEnd", s.getDateEnd());
                    break;
                }
            }

            ArrayList<Grade> grades = stuDB.getGradeStudent(subId);
            boolean isContain = false;
            for (int i = 0; i < grades.size(); i++) {
                for (Grade g : grades) {
                    if ("FE".equals(g.getAssessment().getId()) || "FER".equals(g.getAssessment().getId())) {
                        grades.remove(g);
                        isContain = true;
                        break;
                    }
                }
            }
            if (isContain) {
                Assessment a1 = new Assessment();
                a1.setId("FE");
                a1.setName("Final Exam");
                Grade g1 = new Grade();
                g1.setAssessment(a1);
                g1.setQuantity(1);
                Assessment a2 = new Assessment();
                a2.setId("FER");
                a2.setName("Final Exam Resit");
                Grade g2 = new Grade();
                g2.setAssessment(a2);
                g2.setQuantity(1);
                grades.add(g1);
                grades.add(g2);
            }
            ArrayList<Score> scores = stuDB.getScoreStudent(id, subId, termId, Integer.parseInt(y.trim()));
            request.setAttribute("grades", grades);
            request.setAttribute("scores", scores);
            request.setAttribute("subjectId", subId);
        }

        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        IDate now = new IDate(currentDate.format(formatter));

        request.setAttribute("now", now);
        request.setAttribute("id", id);
        request.setAttribute("terms", terms);
        request.getRequestDispatcher("../view/student/grade.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        request.setAttribute("id", id);

        StudentDBContext stuDB = new StudentDBContext();
        ArrayList<Term> terms = stuDB.getTermStudent(id);

        String termId = request.getParameter("termId");
        String y = request.getParameter("year");
        ArrayList<Subject> subjects = null;
        if (termId != null && y != null) {
            int year = Integer.parseInt(y);
            subjects = stuDB.getSubjectStudent(id, termId, year);
            request.setAttribute("subjects", subjects);
            request.setAttribute("year", year);
            request.setAttribute("termId", termId.trim());
        }
        String subId = request.getParameter("subjectId");
        if (subId != null) {
            for (Subject s : subjects) {
                if (subId.trim().equalsIgnoreCase(s.getId())) {
                    request.setAttribute("dateBegin", s.getDateBegin());
                    request.setAttribute("dateEnd", s.getDateEnd());
                    break;
                }
            }

            ArrayList<Grade> grades = stuDB.getGradeStudent(subId);
            boolean isContain = false;
            for (int i = 0; i < grades.size(); i++) {
                for (Grade g : grades) {
                    if ("FE".equals(g.getAssessment().getId()) || "FER".equals(g.getAssessment().getId())) {
                        grades.remove(g);
                        isContain = true;
                        break;
                    }
                }
            }
            if (isContain) {
                Assessment a1 = new Assessment();
                a1.setId("FE");
                a1.setName("Final Exam");
                Grade g1 = new Grade();
                g1.setAssessment(a1);
                g1.setQuantity(1);
                Assessment a2 = new Assessment();
                a2.setId("FER");
                a2.setName("Final Exam Resit");
                Grade g2 = new Grade();
                g2.setAssessment(a2);
                g2.setQuantity(1);
                grades.add(g1);
                grades.add(g2);
            }
            ArrayList<Score> scores = stuDB.getScoreStudent(id, subId, termId, Integer.parseInt(y.trim()));
            request.setAttribute("grades", grades);
            request.setAttribute("scores", scores);
            request.setAttribute("subjectId", subId);
        }

        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        IDate now = new IDate(currentDate.format(formatter));

        request.setAttribute("now", now);
        request.setAttribute("id", id);
        request.setAttribute("terms", terms);
        
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
