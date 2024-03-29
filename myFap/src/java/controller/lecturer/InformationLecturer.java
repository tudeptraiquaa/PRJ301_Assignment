/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lecturer;

import controller.authentication.BaseRequireAuthentication;
import dal.LecturerDBContext;
import entity.Account;
import entity.Lecturer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.Locale;

/**
 *
 * @author tu
 */
public class InformationLecturer extends BaseRequireAuthentication {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account a)
            throws ServletException, IOException {
        String lecturerId = request.getParameter("id");
        LecturerDBContext lecDB = new LecturerDBContext();

        LocalDate currentDate = LocalDate.now();
        int year = currentDate.getYear();
        WeekFields weekFields = WeekFields.of(Locale.getDefault());
        int week = currentDate.get(weekFields.weekOfWeekBasedYear());
        request.setAttribute("week", week);
        request.setAttribute("year", year);
        if (lecturerId != null) {
            Lecturer lecturer = lecDB.getInformation(lecturerId);
            if (lecturer == null) {
                request.setAttribute("error", "Lecturer id does not exists!");
            } else {
                request.setAttribute("lecturer", lecturer);
            }
        }

        request.getRequestDispatcher("../view/lecturer/information.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account a)
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
