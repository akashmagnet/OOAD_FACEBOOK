package org.iiitb.facebook.util;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AuthenticateInterceptor implements Interceptor
{
	private static final long serialVersionUID = -2799348281841811478L;

	@Override
	public void destroy()
	{

	}

	@Override
	public void init()
	{

	}

	@Override
	public String intercept(ActionInvocation actionInvocation) throws Exception
	{
		Map<String, Object> session = actionInvocation.getInvocationContext().getSession();

		if (session.get("user") == null)
		{
			System.out.println("New Session Created");
			return ActionSupport.LOGIN;
		}
		System.out.println("Session Already Exists");
		return actionInvocation.invoke();
	}

}
