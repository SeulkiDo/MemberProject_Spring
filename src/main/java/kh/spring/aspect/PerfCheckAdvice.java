package kh.spring.aspect;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;


@Aspect
@Component
public class PerfCheckAdvice {
	
	@Autowired
	HttpSession session;
	
	@Around("execution(* kh.spring.practice.HomeController.*(..))")
	public Object perfCheck(ProceedingJoinPoint pjp) {
		long startTime = System.currentTimeMillis();
		
		Object retVal = null;
		try {
			retVal = pjp.proceed();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		long endTime = System.currentTimeMillis();
		
		Signature sign = pjp.getSignature();
		System.out.println("[" + sign.getName() + "메서드가 " + (endTime-startTime)/1000.0 + "초간 수행]");
		return retVal;		
	}
	
	@Pointcut("execute(* kh.spring.practice.HomeController.logout(..)")
	public void logout() {}
	@Pointcut("execute(* kh.spring.practice.HomeController.getImage(..)")
	public void getImage() {}
	@Pointcut("execution(* kh.spring.practice.HomeController.myInfo(..))")
	public void myInfo() {}	
	@Pointcut("execution(* kh.spring.practice.HomeController.update*(..))")
	public void update() {}
	
	//@Around("myInfo() || update()")
	@Around("execution(* kh.spring.practice.HomeController.myInfo(..))")
	public Object loginCheck(ProceedingJoinPoint pjp) {
	//	int loginResult = (Integer) session.getAttribute("loginResult");
		String loginId = (String) session.getAttribute("loginId");
		System.out.println("perfCheckAdvice" + loginId);
		HttpServletRequest request = (HttpServletRequest) pjp.getArgs()[0]; //메서드 첫번째 인자값 request를 받아오면 쓸 수 있음!!
		Object retVal = null;
		try {
			if(loginId!=null) {
				retVal = pjp.proceed();
			}else {
				return "alertDoLogin";
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return retVal;
	}
	
}
