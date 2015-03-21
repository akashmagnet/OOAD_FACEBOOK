package org.iiitb.sis.login;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.Cookie;

import com.opensymphony.xwork2.ActionSupport;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

public class LogoutAction extends ActionSupport implements SessionAware
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7751903212229027485L;
	private Map<String, Object> session;
	

	public Map<String, Object> getSession()
	{
		return session;
	}

	@Override
	public void setSession(Map<String, Object> session)
	{
		this.session = session;

	}

	@Override
	public String execute() throws NumberFormatException, SQLException
	{
		//System.out.println("logout called");
		session.remove("user");
		session.clear();
		Cookie[] cookies = ServletActionContext.getRequest().getCookies(); 
		if (cookies != null) 
			for (int i = 0; i < cookies.length; i++) 
			{ cookies[i].setValue(""); 
			   cookies[i].setPath("/"); 
			   cookies[i].setMaxAge(0); 
			   ServletActionContext.getResponse().addCookie(cookies[i]); }
		/*ServletActionContext.getRequest().getCookies()*/
		ServletActionContext.getRequest().getSession().invalidate();
		return SUCCESS;
	}

}
