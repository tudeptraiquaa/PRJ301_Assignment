/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import dal.GroupDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class ChangeGroup extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();

        String id = request.getParameter("id");
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));

        ArrayList<String> groupsId = gDB.getGroupStudentInFuture(id, month, year);
        if (groupsId.size() == 0) {
            request.setAttribute("error", "Khong co lop hoc nao ton tai!");
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
        
        String subjectIdFrom = request.getParameter("subjectIdFrom");
        if(subjectIdFrom != null){
            request.setAttribute("subjectIdFrom", subjectIdFrom);
        }

        request.setAttribute("id", id);
        request.setAttribute("year", year);
        request.setAttribute("month", month);

        request.getRequestDispatcher("../view/group/change.jsp").forward(request, response);
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
