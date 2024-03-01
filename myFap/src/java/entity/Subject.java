/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author tu
 */
public class Subject extends IEntity{
    private String id, name,prerequisites, groupId;
    private int creadit, semester;
    private Major major;
    private IDate dateBegin, dateEnd;

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public IDate getDateBegin() {
        return dateBegin;
    }

    public void setDateBegin(IDate dateBegin) {
        this.dateBegin = dateBegin;
    }

    public IDate getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(IDate dateEnd) {
        this.dateEnd = dateEnd;
    }
    

    public Major getMajor() {
        return major;
    }

    public void setMajor(Major major) {
        this.major = major;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrerequisites() {
        return prerequisites;
    }

    public void setPrerequisites(String prerequisites) {
        this.prerequisites = prerequisites;
    }

    public int getCreadit() {
        return creadit;
    }

    public void setCreadit(int creadit) {
        this.creadit = creadit;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }
    
    
}
