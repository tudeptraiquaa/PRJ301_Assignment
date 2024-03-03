/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import dal.GroupDBContext;
import dal.StudentDBContext;
import entity.RequireChangeGroup;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class ViewRequireChangeGroup extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();
        
        String id = request.getParameter("id");
        if (id != null) {
            ArrayList<RequireChangeGroup> r = gDB.getRequiresChangeGroup(id);
            if (r.size() == 0) {
                request.setAttribute("request", "No requests were sent");
            } else {
                request.setAttribute("requires", r);
            }
        }

        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));

        request.setAttribute("id", id);
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.getRequestDispatcher("../../view/group/viewRequireChange.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
