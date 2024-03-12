 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import controller.authentication.BaseRequireAuthentication;
import dal.GroupDBContext;
import dal.StudentDBContext;
import entity.Account;
import entity.IDate;
import entity.Student;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class CreateRequire extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        StudentDBContext stuDB = new StudentDBContext();
        String id = request.getParameter("id");
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));
        if (id != null) {
            ArrayList<String> groupsId = gDB.getGroupStudentInFuture(id, month, year);
            if (groupsId.size() == 0) {
                request.setAttribute("id", id);
                request.setAttribute("error", "Chưa đến hạn nộp đơn, đăng ký(Undue for application and registration)!");
                request.getRequestDispatcher("../view/group/createRequire.jsp").forward(request, response);
            } else {
                request.setAttribute("groupsId", groupsId);
            }
            ArrayList<String> subjectsId;
            String groupIdFrom = request.getParameter("groupIdFrom");
            if (groupIdFrom != null) {
                request.setAttribute("groupIdFrom", groupIdFrom);
                subjectsId = gDB.getSubjectStudentInFuture(id, month, year, groupIdFrom);
                if (subjectsId.size() == 0) {
                    request.setAttribute("error", "Khong co mon hoc nao ton tai!");
                } else {
                    request.setAttribute("subjectsId", subjectsId);
                }
            }

            String subjectId = request.getParameter("subjectId");
            if (subjectId != null) {
                request.setAttribute("subjectId", subjectId);
            }

            String idTo = request.getParameter("idTo");
            String groupIdTo;
            if (idTo != null) {
                if (idTo.equalsIgnoreCase(id)) {
                    request.setAttribute("errorTo", "Same id student!!!");
                } else {
                    Student s = stuDB.getInformation(idTo);
                    if (s == null) {
                        request.setAttribute("errorTo", "Student id does not exists!");
                    } else {
                        request.setAttribute("idTo", idTo);
                        groupIdTo = gDB.getGroupStudentFuture(idTo, month, year, subjectId);
                        if (groupIdTo == null) {
                            request.setAttribute("errorTo", "Student " + idTo + "'s subject " + subjectId + " does not exist");
                        } else if (groupIdTo.equalsIgnoreCase(groupIdFrom)) {
                            request.setAttribute("errorTo", "2 students are in the same class, subject " + subjectId);
                        } else {
                            request.setAttribute("groupIdTo", groupIdTo);
                            request.setAttribute("method", "method='post'");
                        }
                    }
                }
            }

            request.setAttribute("id", id);
        }
        request.setAttribute("year", year);
        request.setAttribute("month", month);
        request.getRequestDispatcher("../view/group/createRequire.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        IDate date = new IDate();
        String idFrom = request.getParameter("id");
        String groupIdFrom = request.getParameter("groupIdFrom");
        String subjectId = request.getParameter("subjectId");
        String idTo = request.getParameter("idTo");
        String groupIdTo = request.getParameter("groupIdTo");
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));
        String termId = "";
        if (month >= 1 && month <= 4) {
            termId = "SP";
        } else if (month >= 5 && month <= 8) {
            termId = "SU";
        } else {
            termId = "FA";
        }
        gDB.addRequireChangeGroup(idFrom, groupIdFrom, idTo, groupIdTo, subjectId, termId, year, date.toString());
        request.setAttribute("id", idFrom);
        request.setAttribute("set", "The request was sent successfully");
        request.getRequestDispatcher("../view/home/setSuccess.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
