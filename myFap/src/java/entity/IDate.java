/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author tu
 */
public class IDate extends IEntity {

    private String day, month, year, weekday;

    public IDate() {
    }

    public IDate(Date date) {
        SimpleDateFormat format = new SimpleDateFormat("dd MM yyyy EEE");
        String[] d = format.format(date).split(" ");
        this.day = d[0];
        this.month = d[1];
        this.year = d[2];
        this.weekday = d[3];
    }

    public IDate(String date) {
        String[] d = date.split("-");
        this.day = d[2];
        this.month = d[1];
        this.year = d[0];
    }

    public IDate(String day, String month, String year, String weekday) {
        this.day = day;
        this.month = month;
        this.year = year;
        this.weekday = weekday;
    }

    public IDate(String day, String month, String year) {
        this.day = day;
        this.month = month;
        this.year = year;
    }

    public IDate getDateNow() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String currentDay = currentDate.format(formatter);
        IDate dateNow = new IDate(currentDay);
        return dateNow;
    }

    public int toInt() {
        String d = year + month + day;
        return Integer.parseInt(d);
    }

    public int compare(IDate d) {
        return this.toInt() - d.toInt();
    }

    public String getDay() {
        return day;
    }

    public int getIntWeekday() {
        switch (weekday) {
            case "Mon":
                return 2;
            case "Tue":
                return 3;
            case "Wed":
                return 4;
            case "Thu":
                return 5;
            case "Fri":
                return 6;
        }
        return -1;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getWeekday() {
        return weekday;
    }

    public void setWeekday(String weekday) {
        this.weekday = weekday;
    }

    @Override
    public String toString() {
        return year + "-" + month + "-" + day;
    }
}
