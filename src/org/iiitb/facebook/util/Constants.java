package org.iiitb.facebook.util;

public interface Constants {
	
	//news module--
	public String GET_F_ID="select fid from faculty where fname=?";
	public String GET_C_ID="select cid from courses where cname=?";
	public String GET_N_ID="select nid from news where ntitle=?";
	public String DELETE_NEWS="DELETE FROM  news where nid=?;";
	public String INSERT_NEWS="INSERT INTO news (ntitle,ndetails,cid,fid,isactive) VALUES(?,?,?,?,1);";
	public String GET_COURSE_ID="select * from courses";
	public String GET_FACULTY_ID="select * from faculty";
	public String DISPLAY_USER="select * from news";
	public String UPDATE_INFO = "select * from news where nid=?";
	public String UPDATE_NEWS = "UPDATE news SET ntitle=?,ndetails=?,cid=?,fid=?,isactive=1 WHERE nid=?;";
	//--news module
	
	public String SELECT_USER="select * from user where uname=?";
	public String ERR_UNAME="Invalid Username/ User Does not exists";
	public String ERR_PWD="Invalid Password";
	public String ERR="Error!!!, Contact Admin";
	public String USER_DISABLED="User Disabled, Contact Admin";

	public String UPDATE_LASTLOGGEDIN = "update user set lastloggedin=? where userid=?";
	public String GET_IMAGE = "select userimage from user where userid=?";
	public String GET_ANNOUNCEMENTS = "select ann_id,ann_title from announcement";
	public String GET_ANNOUNCEMENTS_DETAILS = "select ann_id,ann_title,ann_details from announcement where ann_id=? && isactive=1";
	public String GET_NEWS ="(select news_id,news_title from news_interest where news_id in (select news_id from interestNews I,student_interest S where I.InterestID=S.InterestID and S.sid=?))";// "select nid,ntitle from news where cid in (select cid from enrollment where sid=?) && isactive=1";
	public String GET_NEWS1="select interestNews.news_ID,news_interest.news_title from student_interest,interestNews,news_interest where student_interest.sid=? and student_interest.InterestID = interestNews.InterestID and news_interest.news_ID = interestNews.news_ID and news_interest.isactive = 1";
	public String GET_NEWS_DETAILS = "select news_title,news_details from news_interest where news_id=? && isactive=1";//"select ntitle,ndetails,cname,fname from news n,courses c,faculty f where nid=? && n.fid=f.fid && n.cid=c.cid && n.isactive=1";
	public String GET_ADMIN_PROFILE = "select uname,fname,phno,email,doj from faculty,user where utype='admin' && isactive=1 && userid=? && fid=userid";
	public String GET_FACULTY_PROFILE = "select uname,fname,phno,email,doj from faculty,user where utype='faculty' && isactive=1 && userid=? && fid=userid";
	public String GET_STUDENT_PROFILE = "select uname,sname,phno,email,dob,lastdegree,rollno from student,user where utype='student' && isactive=1 && userid=? && sid=userid";
	public String GET_FRIEND_PROFILE = "select sname,phno,email,dob,lastdegree,rollno,sid from student where rollno=?";
	public String GET_COURSE_DETAIL = "select cid,cname,credits,csyllabus	 from courses where ccode=?";
	public String GET_GRADES="select m.semname,c.cname,g.grade_gname,g.weightage,g.passorfail from enrollment e,grade_master g,sem_master m,courses c where e.sid=?  && e.cid=c.cid && e.gid=g.gid && m.semid=e.sem order by m.semname,c.cname";
	public String GET_REG_COURSES = "select m.semname,c.ccode,c.cname,c.credits from enrollment e,sem_master m,courses c where e.sid=? && e.cid=c.cid && m.semid=e.sem order by m.semname,c.cname";
	public String GET_USER_IMAGE = "select userimage from user where userid=? && userimage is not null";
	public String CHANGE_PASSWORD = "update user set upwd=? where userid=? && upwd=?";
}
