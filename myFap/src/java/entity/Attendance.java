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
public class Attendance extends IEntity{
    private String studentId;
    private String studentName;
    private String subjectId;
    private String subjectName;
    private String groupId;
    private boolean status;
    private IDate date;
    private Timestamp timeRecord;
    private String description;
    private String taker;
    private int slotId;
    private Slot slot;
    private String roomId;
    private String lecturerId;
    private boolean takenGroup;

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public boolean isTakenGroup() {
        return takenGroup;
    }

    public void setTakenGroup(boolean takenGroup) {
        this.takenGroup = takenGroup;
    }
    
    

    public Slot getSlot() {
        return slot;
    }

    public void setSlot(Slot slot) {
        this.slot = slot;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getLecturerId() {
        return lecturerId;
    }

    public void setLecturerId(String lecturerId) {
        this.lecturerId = lecturerId;
    }

    
    
    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public String getTaker() {
        return taker;
    }

    public void setTaker(String taker) {
        this.taker = taker;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public IDate getDate() {
        return date;
    }

    public void setDate(IDate date) {
        this.date = date;
    }

    public Timestamp getTimeRecord() {
        return timeRecord;
    }

    public void setTimeRecord(Timestamp timeRecord) {
        this.timeRecord = timeRecord;
    }


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
