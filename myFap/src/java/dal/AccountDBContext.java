/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Account;
import entity.Lecturer;
import entity.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tu
 */
public class AccountDBContext extends DBContext<Account> {

    public Account getAccount(String user, String password) {

        String sql = "select [user], [password], [role] from Account where [user] = ? and [password] = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setUser(rs.getString("user"));
                a.setPassword(rs.getString("password"));
                a.setRole(rs.getInt("role"));
                return a;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    private void addAccount(Student student) {
        String sql = "insert into Account ([user], [password], [role]) values (? , 123, 1)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, student.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void addAccount(Lecturer lecturer) {
        String sql = "insert into Account ([user], [password], [role]) values (? , 123, 2)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lecturer.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<Account> getList() {
        ArrayList<Account> accounts = new ArrayList<>();
        String sql = "select [user], [password], [role] from Account";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setUser(rs.getString("user"));
                a.setPassword(rs.getString("password"));
                a.setRole(rs.getInt("role"));
                accounts.add(a);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }

    public static void main(String[] args) {
        AccountDBContext a = new AccountDBContext();
        ArrayList<Account> accounts = new ArrayList<>();
        accounts = a.getList();
        for (Account acc : accounts) {
            System.out.println(acc.getUser());
        }
    }

}
