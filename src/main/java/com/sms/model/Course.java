package com.sms.model;

public class Course {
	  private int course_id;
	  private String courseName;
	  private String duration;
	  
	  public int getCourseId() {
		return course_id;
	  }
	  public void setCourseId(int course_id) {
		this.course_id = course_id;
	  }
	  public String getCourseName() {
		return courseName;
	  }
	  public void setCourseName(String courseName) {
		this.courseName = courseName;
	  }
	  public String getDuration() {
		return duration;
	  }
	  public void setDuration(String duration) {
		this.duration = duration;
	  }
}
