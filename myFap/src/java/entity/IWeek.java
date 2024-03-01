/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.ArrayList;

/**
 *
 * @author tu
 */
public class IWeek {
    private ArrayList<IDate> dateInWeek;
    private IDate fromDate, toDate;

    public IDate getFromDate() {
        return fromDate;
    }

    public void setFromDate(IDate from) {
        this.fromDate = from;
    }

    public IDate getToDate() {
        return toDate;
    }

    public void setToDate(IDate to) {
        this.toDate = to;
    }

    public ArrayList<IDate> getDateInWeek() {
        return dateInWeek;
    }

    public void setDateInWeek(ArrayList<IDate> dateInWeek) {
        this.dateInWeek = dateInWeek;
    }
    
    
}
