/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.home;

import dal.AccountDBContext;
import entity.Account;
import entity.IDate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.WeekFields;
import java.util.Locale;

/**
 *
 * @author tu
 */
public class Login extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       request.getRequestDispatcher("../view/home/login.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String user = request.getParameter("user");
        String pass = request.getParameter("password");
        AccountDBContext aDB = new AccountDBContext();
        Account acc = aDB.getAccount(user, pass);
        
        if(acc != null){
            HttpSession session = request.getSession();
            session.setAttribute("account", acc);
            request.setAttribute("account", acc);
        }
        //lay nam hien tai
        LocalDate currentDate = LocalDate.now();
        int currentYear = currentDate.getYear();
        
        //lay tuan hien tai
        WeekFields weekFields = WeekFields.of(Locale.getDefault());
        int week = currentDate.get(weekFields.weekOfWeekBasedYear());
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        IDate now = new IDate (currentDate.format(formatter));
        
        // lay thang hien tai
        int month = currentDate.getMonthValue();
        String termId;
        if (month >= 1 && month <= 4) {
            termId = "SP";
        } else if (month >= 5 && month <= 8) {
            termId = "SU";
        } else {
            termId = "FA";
        }
        request.setAttribute("termId", termId);
        request.setAttribute("now", now);
        request.setAttribute("month", month);
        request.setAttribute("week", week);
        request.setAttribute("currentYear", currentYear);
        if(acc != null){
            request.getRequestDispatcher("../view/home/menu.jsp").forward(request, response);
        }
        else{
            request.setAttribute("error", "Thông tin đăng nhập sai!");
            request.getRequestDispatcher("../view/home/login.jsp").forward(request, response);
            
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
