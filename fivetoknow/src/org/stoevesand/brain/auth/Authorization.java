package org.stoevesand.brain.auth;

import java.util.ResourceBundle;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jboss.logging.Logger;
import org.stoevesand.brain.BrainSession;
import org.stoevesand.brain.BrainSystem;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.brain.model.IUserLesson;
import org.stoevesand.brain.persistence.BrainDB;
import org.stoevesand.util.SendMailUsingAuthentication;
import org.stoevesand.util.StringUtils;

public class Authorization {

	private static final int PWC_NONE = 0;
	private static final int PWC_OK = 1;
	private static final int PWC_DBERROR = 2;
	private static final int PWC_NOMATCH = 3;
	private static final int PWC_EMPTY = 4;
	private static final int PWC_USED = 5;
	private static final int PWC_UNCHANGED = 6;

	// private static org.apache.log4j.Logger log =
	// Logger.getLogger("Authorization.class");
	private static Logger log = Logger.getLogger(Authorization.class);

	String username = "";
	String password = "";
	String passnew = "";
	String emailAddress = "";
	String unlock = "";
	String passconfirm = "";
	String captext = "";
	int statusCode = 0;

	String nickMsg = "";

	String nicknew = "";
	String prefixnew = "";

	public String getPrefixnew() {
		return prefixnew;
	}

	public void setPrefixnew(String prefixnew) {
		this.prefixnew = prefixnew;
	}

	private boolean loggedIn;

	public String getEmail() {
		return emailAddress;
	}

	public String getUnlock() {
		return "";
	}

	public void setUnlock(String unlock) {
		this.unlock = unlock;
	}

	public void setEmail(String email) {
		this.emailAddress = email;
	}

	public String getPassconfirm() {
		return passconfirm;
	}

	public void setPassconfirm(String passconfirm) {
		this.passconfirm = passconfirm;
	}

	public String getCaptext() {
		return "";
	}

	public void setCaptext(String captext) {
		this.captext = captext;
	}

	public String getPassword() {
		return password;
	}

	public String getUsername() {
		return username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String remind() {
		// FacesContext context = FacesContext.getCurrentInstance();
		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainDB db = bs.getBrainDB();

		String pw = db.getUserPassword(getEmail());

		if (pw != null) {
			String emailSubjectTxt = "Your Request at notonto.";
			String emailMsgTxt = bs.getReminderText();
			emailMsgTxt = StringUtils.replaceSubstring(emailMsgTxt, "@PASSWORD@", pw);

			// SendMailUsingAuthentication.sendConfirmationMail(email, unlock);
			SendMailUsingAuthentication.sendConfirmationMail(emailAddress, emailSubjectTxt, emailMsgTxt);
			log.info("Reminder sent: " + getEmail());
		} else
			log.error("Reminder requested: " + getEmail());

		emailAddress = "";

		return "reminded";
	}

	public String login() {
		FacesContext context = FacesContext.getCurrentInstance();

		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainSession bss = bs.getBrainSession();
		BrainDB db = bs.getBrainDB();

		String ret = "login";

		User user = null;
		try {
			user = db.getUser(username);

			if (user != null) {
				bss.setCurrentUser(user);

				if (user.getPassword().equals(password)) {
					if (user.unlocked) {
						ret=userLoggedIn(user, bss, context);
						return ret;
					} else {
						loggedIn = false;
						log.info("User still locked:" + user.getName());
						emailAddress = username;
						return "unlock";
					}
				} else {
					log.info("User wrong PW: " + user.getName());
				}
			} else {
				log.info("user " + username + " invalid.");
			}
		} catch (DBException e) {
			return "fatal_DB";
		}

		ResourceBundle bundle = ResourceBundle.getBundle("org.stoevesand.brain.i18n.MessagesBundle", context.getViewRoot().getLocale());
		context.addMessage(null, new FacesMessage(bundle.getString("loginfailed")));
		bss.incrementLoginCounter();

		return "logout";
	}

	/*
	 * Verbinden eines bestehenden notonto accounts mit einem Facebook account
	 */
	public String fb_link() {
		FacesContext context = FacesContext.getCurrentInstance();

		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainSession bss = bs.getBrainSession();
		BrainDB db = bs.getBrainDB();

		//String ret = "login";

		User user = null;
		try {
			user = db.getUser(username);

			if (user != null) {
				if (user.getPassword().equals(password)) {
					return "user";
				} else {
					log.info("User wrong PW: " + user.getName());
				}
			} else {
				log.info("user " + username + " invalid.");
			}
		} catch (DBException e) {
			return "fatal_DB";
		}

		ResourceBundle bundle = ResourceBundle.getBundle("org.stoevesand.brain.i18n.MessagesBundle", context.getViewRoot().getLocale());
		context.addMessage(null, new FacesMessage(bundle.getString("loginfailed")));
		bss.incrementLoginCounter();

		return null;
	}

	// alles was man erledigen muss, wenn ein user richtig ist.
	public String userLoggedIn(User user, BrainSession bss, FacesContext context) {
		String ret = "login";
		loggedIn = true;

		try {
			user.storeLastLogin();
			user.storeScore();
			bss.login();
			log.info("User logged in: " + user.getName());
			log.info("Browser: " + getBrowser(context));

			// Sonderfall direkteinstieg. Wenn eine Userlesson ID übergeben
			// wurde
			// dann wird sie geladen und gleich auf die lesson.jsf verzweigt.
			String sulid = bss.getParameter("ulid");
			System.out.println("ULID: " + sulid);
			long ulid = 0;
			if (sulid != null) {
				try {
					ulid = Long.parseLong(sulid);
					IUserLesson userLesson = (IUserLesson) user.getUserLesson(ulid);
					if (userLesson != null) {
						bss.learnLesson(userLesson);
						ret = "lesson";
					} else
						ret = "user";
				} catch (Exception e) {
				}
			}
			// Ende: Direkteinstieg
System.out.println("RET: "+ret);
			if (user.getIsAdmin()) {
				return "admin_user";
			}
		} catch (DBException e) {
			return "fatal_DB";
		}
		return ret;
	}

	private String getBrowser(FacesContext context) {
		String browser = "unknown";
		try {
			HttpServletRequest sr = (HttpServletRequest) context.getExternalContext().getRequest();
			browser = sr.getHeader("User-Agent");
		} catch (Exception e) {
		}
		return browser;
	}

	public String logout() {
		loggedIn = false;
		username = "";

		// try {
		// BrainSystem.getBrainSystem().getBrainSession().getFacebookClient().logout();
		// } catch(Exception e){};

		FacesContext context = FacesContext.getCurrentInstance();
		ExternalContext ectx = context.getExternalContext();
		HttpSession session = (HttpSession) ectx.getSession(false);
		session.invalidate();

		return "logout";
	}

	public String register() {
		log.debug("register");

		BrainDB db = BrainSystem.getBrainSystem().getBrainDB();
		try {
			if (!passwordsMatch()) {
				FacesContext context = FacesContext.getCurrentInstance();

				UIComponent root = context.getViewRoot();
				UIComponent passinput = root.findComponent("regform:passinput");
				UIComponent passconfinput = root.findComponent("regform:passconfinput");

				log.debug("passinput: " + passinput);
				if ((passinput != null) && (passconfinput != null)) {
					String message = "pdm";
					context.addMessage(passinput.getClientId(context), new FacesMessage(message));
					context.addMessage(passconfinput.getClientId(context), new FacesMessage(message));
				}

				return "passnomatch";
			}
			if (db.emailIsAlreadyUsed(emailAddress)) {
				return "emailused";
			}
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "captcha";
	}

	public String deleteAccount() {
		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainSession bss = bs.getBrainSession();

		String testpass = passnew;
		passnew = "";

		String ret = null;
		if (testpass.length() > 0) {
			BrainDB db = bs.getBrainDB();
			User cu = bss.getCurrentUser();

			try {
				if (cu.getPassword().equals(testpass)) {
					db.deleteAccount(cu);
					ret = logout();
				} else {
					bss.getBrainMessage().setPwErrorText("Wrong password!");
					ret = null;
				}
			} catch (DBException e) {
			}
		} else {
			bss.getBrainMessage().setPwErrorText("Please enter your password!");
		}

		return ret;
	}

	public String alterPassword() {

		if (passnew.length() == 0) {
			setStatusCode(PWC_EMPTY);
		} else if (passnew.equals(passconfirm)) {
			BrainSystem bs = BrainSystem.getBrainSystem();
			BrainDB db = bs.getBrainDB();
			User cu = bs.getBrainSession().getCurrentUser();

			try {
				db.changePassword(cu, passnew);
			} catch (DBException e) {
				setStatusCode(PWC_DBERROR);
			}
			setStatusCode(PWC_OK);
		} else {
			setStatusCode(PWC_NOMATCH);
		}

		return null;
	}

	public String alterStatusMailFreq() {
		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainDB db = bs.getBrainDB();
		User cu = bs.getBrainSession().getCurrentUser();

		try {
			db.changeStatusMailFreq(cu);
		} catch (DBException e) {
		}
		return null;
	}

	public String alterNickname() {

		BrainSystem bs = BrainSystem.getBrainSystem();

		setNickMsg("");

		if (nicknew.length() == 0) {
			setStatusCode(PWC_EMPTY);
			setNickMsg(bs.getBrainSession().getResourceBundle().getString("msg_required"));
		} else if ((nicknew.length() > 15) || (nicknew.length() < 5)) {
			setStatusCode(PWC_NOMATCH);
			setNickMsg(bs.getBrainSession().getResourceBundle().getString("msg_nicklong"));
		} else if (!nicknew.matches("[a-zA-Z0-9]*")) {
			setStatusCode(PWC_NOMATCH);
			setNickMsg(bs.getBrainSession().getResourceBundle().getString("msg_nickregex"));
		} else {
			BrainDB db = bs.getBrainDB();
			User cu = bs.getBrainSession().getCurrentUser();

			if (nicknew.equals(cu.getNick())) {
				setStatusCode(PWC_UNCHANGED);
			} else {
				try {
					if (db.checkNickname(cu, nicknew)) {
						cu.setNick(nicknew);
						db.changeNickname(cu, nicknew);
						bs.updateTop5(cu);
						// setStatusCode(PWC_OK);
					} else {
						setStatusCode(PWC_USED);
						setNickMsg(bs.getBrainSession().getResourceBundle().getString("msg_nickused"));
					}
				} catch (DBException e) {
					setStatusCode(PWC_DBERROR);
				}
			}
		}
		nicknew = "";
		return null;
	}

	public String alterPrefix() {

		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainSession bss = bs.getBrainSession();

		if (prefixnew.length() == 0) {
			bss.getBrainMessage().setPrefixErrorText(bs.getBrainSession().getResourceBundle().getString("msg_required"));
		} else if ((prefixnew.length() > 5) || (prefixnew.length() < 2)) {
			bss.getBrainMessage().setPrefixErrorText(bs.getBrainSession().getResourceBundle().getString("msg_prefixlong"));
		} else if (!prefixnew.matches("[a-zA-Z0-9]*")) {
			bss.getBrainMessage().setPrefixErrorText(bs.getBrainSession().getResourceBundle().getString("msg_prefixregex"));
		} else {
			BrainDB db = bs.getBrainDB();
			User cu = bs.getBrainSession().getCurrentUser();

			if (!prefixnew.equals(cu.getPrefix())) {
				try {
					if (db.checkUserPrefix(cu, prefixnew)) {
						cu.setPrefix(prefixnew);
						db.changePrefix(cu, prefixnew);
					} else {
						bss.getBrainMessage().setPrefixErrorText(bs.getBrainSession().getResourceBundle().getString("msg_prefixused"));
					}
				} catch (DBException e) {
					setStatusCode(PWC_DBERROR);
				}
			}
		}
		prefixnew = "";
		return null;
	}

	public String prepareOptions() {
		passnew = "";
		passconfirm = "";
		setStatusCode(0);
		return "options";
	}

	public String confirm() {
		try {
			FacesContext context = FacesContext.getCurrentInstance();

			BrainSystem bs = BrainSystem.getBrainSystem();
			// BrainDB db = BrainSystem.getBrainSystem().getBrainDB();

			log.debug("confirm");

			unlock = randomUnlockString();

			String emailSubjectTxt = "Your Registration at notonto.";
			String emailMsgTxt = bs.getRegisterText();
			emailMsgTxt = StringUtils.replaceSubstring(emailMsgTxt, "@CODE@", unlock);

			String rcp = context.getExternalContext().getRequestContextPath();

			String unlockLink = "http://www.notonto.de" + rcp + "/unlock/" + emailAddress + "/" + unlock;
			emailMsgTxt = StringUtils.replaceSubstring(emailMsgTxt, "@LINK@", unlockLink);

			// SendMailUsingAuthentication.sendConfirmationMail(email, unlock);
			SendMailUsingAuthentication.sendConfirmationMail(emailAddress, emailSubjectTxt, emailMsgTxt);

			User user = new User(emailAddress, password, unlock, false);
			user.store();
			BrainSystem.debug("bs: registeredUser -> " + user.getName());
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "unlock";
	}

	public String sendCode() {
		FacesContext context = FacesContext.getCurrentInstance();
		User user = (User) context.getExternalContext().getRequestMap().get("user");

		System.out.println("sendCode -> " + user.getName());
		System.out.println("sendCode -> " + user.getUnlock());

		reconfirm(user);

		return null;
	}

	public void reconfirm(User user) {

		FacesContext context = FacesContext.getCurrentInstance();

		BrainSystem bs = BrainSystem.getBrainSystem();
		// BrainDB db = BrainSystem.getBrainSystem().getBrainDB();

		log.debug("reconfirm");

		String emailSubjectTxt = "Your Registration at notonto.";
		String emailMsgTxt = "### Aufgrund eines Fehler im Mailsystem wurde Ihr Freischaltcode nicht verschickt. \n";
		emailMsgTxt += "### Wir schicken Ihnen den Code daher erneut zu.\n";
		emailMsgTxt += "### Wir bitten die Verzögerung zu entschuldigen. - Ihr notonto-Team.\n\n";
		emailMsgTxt += bs.getRegisterText();

		emailMsgTxt = StringUtils.replaceSubstring(emailMsgTxt, "@CODE@", unlock);

		String rcp = context.getExternalContext().getRequestContextPath();

		String unlockLink = "http://www.notonto.de" + rcp + "/unlock/" + user.getName() + "/" + user.getUnlock();
		emailMsgTxt = StringUtils.replaceSubstring(emailMsgTxt, "@LINK@", unlockLink);

		// SendMailUsingAuthentication.sendConfirmationMail(email, unlock);
		SendMailUsingAuthentication.sendConfirmationMail(user.getName(), emailSubjectTxt, emailMsgTxt);

		BrainSystem.debug("reconfirmation -> " + user.getName());

	}

	public String unlock() {
		log.debug("Vcode");

		// String message = "Dieser Code ist leider nicht richtig!";

		BrainDB db = BrainSystem.getBrainSystem().getBrainDB();
		boolean unlocked;
		try {
			unlocked = db.unlockUser(emailAddress, unlock);

			if (!unlocked) {
				// ((UIInput) toValidate).setValid(false);
				// context.addMessage(toValidate.getClientId(context), new
				// FacesMessage(message));
				log.debug("wrong unlock key");
				return "unlock";
			}
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "unlocked";
	}

	String randomUnlockString() {
		String elegibleChars = "ABCDEFGHJKLMPQRSTUVWXYabcdefhjkmnpqrstuvwxy23456789";
		char[] chars = elegibleChars.toCharArray();
		int charsToPrint = 5;

		StringBuffer finalString = new StringBuffer();

		for (int i = 0; i < charsToPrint; i++) {
			double randomValue = Math.random();
			int randomIndex = (int) Math.round(randomValue * (chars.length - 1));
			char characterToShow = chars[randomIndex];
			finalString.append(characterToShow);
		}
		return finalString.toString();
	}

	public void validateEmail(FacesContext context, UIComponent toValidate, Object value) {
		log.debug("VE");
		String message = "Wrong email";
		String email = (String) value;
		if (email.indexOf('@') < 1) {
			((UIInput) toValidate).setValid(false);
			context.addMessage(toValidate.getClientId(context), new FacesMessage(message));
		}
	}

	public boolean passwordsMatch() {

		log.debug("VP: compare " + password + " - " + passconfirm);

		return password.equals(passconfirm);
	}

	public void validateRights(FacesContext context, UIComponent toValidate, Object value) {
		log.debug("VR");

		String message = "Bitte stimmen Sie den Benutzungshinweisen zu!";
		Boolean rights = (Boolean) value;
		if (!rights.booleanValue()) {
			((UIInput) toValidate).setValid(false);
			context.addMessage(toValidate.getClientId(context), new FacesMessage(message));
		}
	}

	public void validateCaptcha(FacesContext context, UIComponent toValidate, Object value) {
		log.debug("VC");

		HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
		String lastcap = "" + request.getSession().getAttribute("captcha");

		String message = "Wrong captcha";
		String captext = (String) value;
		if (!lastcap.trim().toUpperCase().equals(captext.trim().toUpperCase())) {
			((UIInput) toValidate).setValid(false);
			context.addMessage(toValidate.getClientId(context), new FacesMessage(message));
		}

	}

	public boolean getIsLoggedIn() {
		return loggedIn;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	public String getPassnew() {
		return passnew;
	}

	public void setPassnew(String passnew) {
		this.passnew = passnew;
	}

	public String getNicknew() {
		return "";
	}

	public void setNicknew(String nicknew) {
		this.nicknew = nicknew.trim();
	}

	public String getNickMsg() {
		return nickMsg;
	}

	public void setNickMsg(String nickMsg) {
		this.nickMsg = nickMsg;
	}
}
