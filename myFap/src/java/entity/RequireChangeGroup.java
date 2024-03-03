/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Timestamp;

/**
 *
 * @author tu
 */
public class RequireChangeGroup {
    private String subjectId, idFrom, groupIdFrom, termId, idTo, groupIdTo, status;
    private int year;
    private String dateRequire;
    private Timestamp dateProcessing;

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public String getIdFrom() {
        return idFrom;
    }

    public void setIdFrom(String idFrom) {
        this.idFrom = idFrom;
    }

    public String getGroupIdFrom() {
        return groupIdFrom;
    }

    public void setGroupIdFrom(String groupIdFrom) {
        this.groupIdFrom = groupIdFrom;
    }

    public String getTermId() {
        return termId;
    }

    public void setTermId(String termId) {
        this.termId = termId;
    }

    public String getIdTo() {
        return idTo;
    }

    public void setIdTo(String idTo) {
        this.idTo = idTo;
    }

    public String getGroupIdTo() {
        return groupIdTo;
    }

    public void setGroupIdTo(String groupIdTo) {
        this.groupIdTo = groupIdTo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getDateRequire() {
        return dateRequire;
    }

    public void setDateRequire(String dateRequire) {
        this.dateRequire = dateRequire;
    }

    public Timestamp getDateProcessing() {
        return dateProcessing;
    }

    public void setDateProcessing(Timestamp dateProcessing) {
        this.dateProcessing = dateProcessing;
    }
    
    
}
