package org.stoevesand.brain.facebook;

import java.util.TreeMap;

import javax.faces.context.FacesContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.jboss.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.stoevesand.brain.BrainSession;
import org.stoevesand.brain.BrainSystem;
import org.stoevesand.brain.auth.Authorization;
import org.stoevesand.brain.auth.FacebookUser;
import org.stoevesand.brain.auth.User;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.brain.persistence.BrainDB;

import com.socialjava.TinyFBClient;

public class FacebookClient {

	private static Logger log = Logger.getLogger(FacebookClient.class);
	private static String api_key = "15b68e3e9a6455c307d652a38a0fcf05";
	private static String secret = "b20488e553a6cb849cd3e7961f845488";

	private String first_name = "";
	private String last_name = "";

	TinyFBClient tinyfb = null;
	private boolean hasValidSession;

	public FacebookClient() {
	}

	public void init() {

		if (tinyfb == null)
			tinyfb = new TinyFBClient(api_key, secret);

		FacesContext context = FacesContext.getCurrentInstance();
		HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();

		try {
			String cookie_name = api_key + "_session_key";
			System.out.println("CN: " + cookie_name);
			String sessionKey = getCookie(request, cookie_name);

			System.out.println("SK: " + sessionKey);

			if (sessionKey != null) {
				tinyfb.setSession(sessionKey);
				hasValidSession = true;
			} else {
				hasValidSession = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String getCookie(HttpServletRequest request, String cookieName) {
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(cookieName)) {
				return cookie.getValue();
			}
		}
		return null;
	}

	long fbUserID = -1;

	long getUserID() {
		if ((fbUserID < 0) && hasValidSession) {
			if (tinyfb != null) {
				try {
					System.out.println("fb: " + tinyfb);
					TreeMap<String, String> tm = new TreeMap<String, String>();
					tm.put("uid", ""); // empty String for logged on user
					String suid = tinyfb.call("users.getLoggedInUser", tm);
					System.out.println("SUID: " + suid);
					fbUserID = Long.parseLong(suid);
				} catch (NumberFormatException nfe) {
					System.out.println("not a valid session.");
					hasValidSession = false;
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else
				log.error("FB is null");
		}
		return fbUserID;
	}

	public String getUserInfo(FacebookUser user) {
		String ret = "";
		TreeMap<String, String> tm = new TreeMap<String, String>();
		tm.put("uids", user.getFacebookIdString()); // empty String for logged on
		// user
		//tm.put("fields", "uid, first_name, last_name, name, timezone, birthday, sex, affiliations, locale, profile_url, proxied_email");
		tm.put("fields", "uid, name, proxied_email");
		String result = tinyfb.call("users.getInfo", tm);
		//System.out.println("TM: " + tm);

		try {
			JSONArray ja = new JSONArray(result);

			JSONObject jo = ja.getJSONObject(0);
			String name = jo.getString("name");
			user.setName(name);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("UI: " + result);
		return first_name + " " + last_name;
	}

	public void logout() {
		TreeMap<String, String> tm = new TreeMap<String, String>();
		String res = tinyfb.call("auth.expireSession", tm);
		//System.out.println("LO: " + res);
		hasValidSession = false;
		tinyfb = null;
	}

	FacebookUser fbuser = null;

	public FacebookUser getUser() {
		return fbuser;
	}

	// ACTION
	public String fb_login() {
		System.out.println("###FB");

		init();

		long fbuid = getUserID();
		if (fbuid > 0) {
			fbuser = loginFacebookUser(fbuid);
			if (fbuser != null) {
				getUserInfo(fbuser);
				return "user";
			} else {
				fbuser = new FacebookUser(fbuid);
				getUserInfo(fbuser);
				return "fbnew";
			}
		}

		return "index";
	}

	public FacebookUser loginFacebookUser(long facebookID) {
		FacesContext context = FacesContext.getCurrentInstance();

		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainSession bss = bs.getBrainSession();
		BrainDB db = bs.getBrainDB();
		Authorization auth = BrainSystem.getBrainSystem().getAuthorization();

		FacebookUser user = null;
		try {
			user = db.getFacebookUser(facebookID);

			if (user != null) {
				bss.setCurrentUser(user);
				auth.userLoggedIn(user, bss, context);
			} else {
				log.info("facebook id " + facebookID + " unknown.");
			}
		} catch (DBException e) {
			log.error(e);
		}

		return user;
	}

	// ACTION
	public String fb_createAccount() {

		if (fbuser != null) {
			try {
				FacesContext context = FacesContext.getCurrentInstance();
				BrainSystem bs = BrainSystem.getBrainSystem();
				BrainSession bss = bs.getBrainSession();
				// BrainDB db = bs.getBrainDB();
				Authorization auth = BrainSystem.getBrainSystem().getAuthorization();

				fbuser.store();
				bss.setCurrentUser(fbuser);
				auth.userLoggedIn(fbuser, bss, context);
			} catch (DBException e) {
				e.printStackTrace();
			}
		}
		return "user";
	}

	public void fb_link(User user) {
		if (fbuser != null) {
			try {
				FacesContext context = FacesContext.getCurrentInstance();
				BrainSystem bs = BrainSystem.getBrainSystem();
				BrainSession bss = bs.getBrainSession();
				BrainDB db = bs.getBrainDB();
				Authorization auth = BrainSystem.getBrainSystem().getAuthorization();

				long facebookID=fbuser.getFacebookId();
				db.fb_linkUser(user, facebookID);
				fbuser = db.getFacebookUser(facebookID);
				getUserInfo(fbuser);
				bss.setCurrentUser(fbuser);
				auth.userLoggedIn(fbuser, bss, context);
			} catch (DBException e) {
				e.printStackTrace();
			}
		}
	}
}
