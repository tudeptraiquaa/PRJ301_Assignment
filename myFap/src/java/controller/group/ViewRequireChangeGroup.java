/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.group;

import controller.authentication.BaseRequireAuthentication;
import dal.GroupDBContext;
import entity.Account;
import entity.RequireChangeGroup;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class ViewRequireChangeGroup extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account acount)
            throws ServletException, IOException {
        GroupDBContext gDB = new GroupDBContext();

        HttpSession session = request.getSession();

        Account a = (Account) session.getAttribute("account");
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));
        if (a != null && a.getRole() == 3) {
            ArrayList<RequireChangeGroup> processing = gDB.getRequiresChangeGroup();
            if (processing.size() == 0) {
                request.setAttribute("request", "All requests have been processed");
            } else {
                request.setAttribute("processing", processing);
                request.setAttribute("month", month);
                request.setAttribute("year", year);
                request.getRequestDispatcher("../../view/group/viewRequireChange.jsp").forward(request, response);
            }
        }

        String id = request.getParameter("id");
        if (id != null) {
            ArrayList<RequireChangeGroup> r = gDB.getRequiresChangeGroup(id);
            if (r.size() == 0) {
                request.setAttribute("request", "No requests were sent");
            } else {
                request.setAttribute("processing", r);
            }
            
            ArrayList<RequireChangeGroup> r_done = gDB.getRequiresChangeGroupProcessed(id);
            if (r_done.size() != 0) {
                request.setAttribute("processed", r_done);
            }
        }

        request.setAttribute("id", id);
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.getRequestDispatcher("../../view/group/viewRequireChange.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
