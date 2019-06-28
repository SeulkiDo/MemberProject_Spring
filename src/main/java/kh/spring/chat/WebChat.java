package kh.spring.chat;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session; //웹소켓 세션
import javax.websocket.server.ServerEndpoint;

import kh.spring.dto.MemberDTO;

@ServerEndpoint(value="/chat",configurator=HttpSessionSetter.class)
public class WebChat {

	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	private static HashMap<Session,String> userInfo = new HashMap<Session, String>();

	
	/*서버에 메세지가 도착하는 순간*/
	@OnMessage
	public void onMessage(String msg, Session session) throws Exception{
		
		synchronized (clients) {
			System.out.println("채팅채팅 : " + userInfo.get(session));
			String userId = userInfo.get(session);
			for(Session each : clients) {	
				if(each != session) {	
					each.getBasicRemote().sendText("<div class=\"someone\">"+ userId + " : " + msg + "</div>");
				}else {
					each.getBasicRemote().sendText("<div class=\"me\">나 : " + msg + "</div>");
				}
			}

		}	
	}


	@OnOpen
	public void onOpen(Session session,EndpointConfig ec) {
		HttpSession hsession = (HttpSession)ec.getUserProperties().get("httpSession"); // put해놓은 정보 가져오면 됨!

		//System.out.println(ec.getUserProperties().get("loginId"));
		String chatId = (String) hsession.getAttribute("loginId");
		
		clients.add(session);
		userInfo.put(session, chatId);
	}

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
	}
}
