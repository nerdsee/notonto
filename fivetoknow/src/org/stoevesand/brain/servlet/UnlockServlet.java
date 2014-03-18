package org.stoevesand.brain.servlet;

import java.io.IOException;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.faces.context.FacesContext;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.stoevesand.brain.BrainSystem;
import org.stoevesand.brain.auth.User;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.brain.model.IUserLesson;
import org.stoevesand.brain.model.UserItem;

public class UnlockServlet extends HttpServlet {

	private static Logger log = Logger.getLogger(UnlockServlet.class);

	private static final long serialVersionUID = 1L;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("req: " + request.getPathInfo());
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String ret = "";
		try {
			StringTokenizer st = new StringTokenizer(request.getPathInfo(), "/");

			String userId = st.nextToken();
			String code = st.nextToken();

			// System.out.printf("user: %s - pass: %s - action:
			// %s\n",userId,pass,action);

			log.debug("unlock: " + userId + "("+code+")");
			
			boolean unlocked = BrainSystem.getBrainSystemNoFaces().getBrainDB().unlockUser(userId, code);

			log.debug("unlock servlet: " + unlocked);

			String rcp = request.getContextPath();
			
			if (unlocked)
				response.sendRedirect(rcp + "/auth/unlocked.jsf");
			else
				response.sendRedirect(rcp + "/auth/unlock.jsf");

		} catch (DBException e) {
			e.printStackTrace();
		}

		
	}

}
