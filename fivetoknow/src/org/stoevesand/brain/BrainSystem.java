package org.stoevesand.brain;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import java.util.Vector;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.model.ListDataModel;

import org.apache.log4j.Logger;
import org.apache.myfaces.trinidad.context.RequestContext;
import org.stoevesand.brain.auth.Authorization;
import org.stoevesand.brain.auth.User;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.brain.model.Answer;
import org.stoevesand.brain.model.IUserLesson;
import org.stoevesand.brain.model.Item;
import org.stoevesand.brain.model.Lesson;
import org.stoevesand.brain.model.UserItem;
import org.stoevesand.brain.persistence.Administration;
import org.stoevesand.brain.persistence.BrainDB;
import org.stoevesand.brain.persistence.BrainDBFactory;
import org.stoevesand.tools.DictMake;
import org.stoevesand.util.News;
import org.stoevesand.util.SendMailUsingAuthentication;
import org.stoevesand.util.StringUtils;

public class BrainSystem {

	private static Logger log = Logger.getLogger(BrainSystem.class);

	private static boolean _DEBUG_ = false;

	private static BrainSystem _instance = null;

	private BrainDB brainDB = null;

	private long breakTimes[] = new long[10];

	private String brainHomeDir;

	private int maxItemsLevel0;

	// private String answerText;

	private String localFileName;

	private String invertLessonID;

	Vector<Category> categories = null;
	// Vector<News> news = null;
	ListDataModel news = null;
	ListDataModel allnews = null;

	private String markedText;

	private String registerText;

	public static BrainSystem getBrainSystem() {
		if (_instance == null) {
			FacesContext context = FacesContext.getCurrentInstance();
			_instance = (BrainSystem) accessBeanFromFacesContext("BrainSystem", context);
		}
		return _instance;
	}

	public static BrainSystem getBrainSystemNoFaces() {
		if (_instance == null) {
			_instance = new BrainSystem();
		}
		return _instance;
	}

	private void init() {

		brainHomeDir = System.getProperty("fivetoknow.dir");

		debug("INIT.");
		File configFile = new File(brainHomeDir + "/brain_config.xml");
		Administration.loadConfig(configFile, this);

		loadTemplates();

	}

	private void loadTemplates() {

		brainHomeDir = System.getProperty("fivetoknow.dir");

		debug("INIT. ");
		File registerFile = new File(brainHomeDir + "/register.txt");

		registerText = StringUtils.loadFileToString(registerFile);

	}

	public String invertLesson() {

		long id = Long.parseLong(invertLessonID);

		Lesson lesson;
		try {
			lesson = getBrainDB().getLesson(id);

			DictMake.invertLesson(lesson);

		} catch (DBException e) {
			e.printStackTrace();
		}

		return null;
	}

	public String fileLessonLocalUpload() {
		FacesContext context = FacesContext.getCurrentInstance();
		UIComponent root = context.getViewRoot();
		UIComponent fileinput = root.findComponent("localUpload:localFileName");

		File file = new File(localFileName);
		if (file != null) {

			// log.debug("f: " + file.getContentType());
			log.debug("f: " + file.getName());

			try {
				Administration.loadLesson(new FileInputStream(file));
				FacesMessage message = new FacesMessage("Successfully uploaded file " + file.getName() + " ");
				if (fileinput != null)
					context.addMessage(fileinput.getClientId(context), message);
			} catch (IOException e) {
				FacesMessage message = new FacesMessage("Error loading file " + e.getMessage());
				if (fileinput != null)
					context.addMessage(fileinput.getClientId(context), message);
				e.printStackTrace();
			}

			getBrainSession().unloadLibrary();

			System.out.println("Successfully uploaded file " + file.getName() + " ");
		} else {
			FacesMessage message = new FacesMessage("File not found.");
			if (fileinput != null)
				context.addMessage(fileinput.getClientId(context), message);
		}
		return null;
	}

	// public void fileLessonUploaded(ValueChangeEvent event) {
	// UploadedFile file = (UploadedFile) event.getNewValue();
	// if (file != null) {
	// FacesContext context = FacesContext.getCurrentInstance();
	// FacesMessage message = new FacesMessage("Successfully uploaded file " +
	// file.getFilename() + " (" + file.getLength() + " bytes)");
	// context.addMessage(event.getComponent().getClientId(context), message);
	// // Here's where we could call file.getInputStream()
	//
	// log.debug("f: " + file.getContentType());
	// log.debug("f: " + file.getFilename());
	//
	// try {
	// Administration.loadLesson(file.getInputStream());
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	//
	// getBrainSession().unloadLibrary();
	//
	// System.out.println("Successfully uploaded file " + file.getFilename() +
	// " (" + file.getLength() + " bytes)");
	// }
	// }

	public String loadLessons() {
		File dbfile = new File(brainHomeDir + "/lessons/radikal214-ch-de.txt.dict.xml");
		Administration.loadDB(dbfile);
		return "ok";
	}

	public String doNothing() {
		return null;
	}

	public static void debug(String msg) {
		if (_DEBUG_)
			System.out.println(msg);
	}

	public BrainSystem() {
		brainDB = BrainDBFactory.getInstance().getBrainDB();
		init();
	}

	public BrainDB getBrainDB() {
		return brainDB;
	}

	public String getNow() {
		return "" + System.currentTimeMillis();
	}

	public Vector<User> getUsers() {
		Vector<User> ret = null;
		debug("bs: getUsers()");
		try {
			ret = brainDB.getUsers();
		} catch (DBException e) {
			e.printStackTrace();
		}
		return ret;
	}

	public Vector<Lesson> getLessons() {
		Vector<Lesson> ret = null;
		debug("bs: getLessons()");
		try {
			ret = brainDB.getLessons();
		} catch (DBException e) {
			e.printStackTrace();
		}
		return ret;
	}

	public Vector<Lesson> getUnsubscribedLessons() {
		Vector<Lesson> lessons;
		Vector<Lesson> ret = new Vector<Lesson>();
		try {
			lessons = brainDB.getLessons();

			User currentUser = getBrainSession().getCurrentUser();
			Iterator<Lesson> it = lessons.iterator();
			while (it.hasNext()) {
				Lesson lesson = it.next();
				if (!currentUser.hasLesson(lesson)) {
					ret.add(lesson);
				}
			}
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return ret;
	}

	ListDataModel userModel = null;

	public ListDataModel getUserList() {

		// / TODO: wieder reinmachen
		// if (userModel == null) {
		Vector<User> users = new Vector<User>();

		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainDB brainDB = bs.getBrainDB();

		try {
			users = brainDB.getUsers();
			userModel = new ListDataModel(users);
		} catch (DBException e) {
			e.printStackTrace();
		}
		// }
		return userModel;
	}

	public ListDataModel getLessonLibrary() {
		BrainSession session = getBrainSession();
		return session.getLibrary();
	}

	Vector<UserScore> top5 = null;
	long lastTop5 = 0;
	// long top5Reload = 1000 * 60 * 60; // Stunde
	long top5Reload = 1000 * 60 * 10; // 10 min

	public Vector<UserScore> getTop5() {

		long now = System.currentTimeMillis();
		if (now - top5Reload > lastTop5) {
			lastTop5 = now;
			BrainDB brainDB = getBrainDB();
			top5 = brainDB.getTop5();
		}
		return top5;
	}

	public Date getLastTop5() {
		return new Date(lastTop5);
	}

	public void updateTop5(User cu) {
		for (UserScore us : getTop5()) {
			if (us.getName().equals(cu.getName())) {
				us.nick = cu.getNick();
				log.debug("nick adjusted.");
			}
		}
		// log.debug("cu: " + cu.getName());
		// for(UserScore us : getTop5()) {
		// log.debug("us: " + us.getName());
		// }

	}

	public Vector<Category> getCategories() {
		loadCategories();
		return categories;
	}

	private void loadCategories() {
		if (categories == null) {
			try {
				categories = brainDB.getCategories();
			} catch (DBException e) {
				e.printStackTrace();
			}
		}
	}

	public ListDataModel getNews() {
		news = loadNews(getBrainSession().getCurrentLocale());
		return news;
	}

	public ListDataModel getAllNews() {
		if (allnews == null) {
			allnews = loadNews(null);
		}
		return allnews;
	}

	private ListDataModel loadNews(Locale locale) {
		ListDataModel lnews = null;
		try {
			lnews = new ListDataModel(brainDB.getNews(locale));
		} catch (DBException e) {
			e.printStackTrace();
		}
		return lnews;
	}

	public void unloadCategories() {
		categories = null;
	}

	public Vector<IUserLesson> getUserLessons() {
		debug("bs: getUserLessons()");
		return getBrainSession().getCurrentUser().getLessons();
	}

	public Lesson getCurrentLesson() {
		Lesson lesson = null;
		try {
			lesson = getBrainSession().getCurrentLesson();
		} catch (Exception e) {
		}

		return lesson;
	}

	public BrainSession getBrainSession() {

		FacesContext context = FacesContext.getCurrentInstance();
		BrainSession session = (BrainSession) accessBeanFromFacesContext("BrainSession", context);

		return session;
	}

	public Authorization getAuthorization() {

		FacesContext context = FacesContext.getCurrentInstance();
		Authorization auth = (Authorization) accessBeanFromFacesContext("Auth", context);

		return auth;
	}

	public String selectUser() {
		FacesContext context = FacesContext.getCurrentInstance();
		User user = (User) context.getExternalContext().getRequestMap().get("user");

		// storeBeanFromFacesContext("CurrentUser",context, user);
		getBrainSession().setCurrentUser(user);

		debug("bs: selectUser -> " + user.getName());

		return "user";
	}

	public String infoLesson() {
		try {
			FacesContext context = FacesContext.getCurrentInstance();
			// LessonWrapper lw = (LessonWrapper)
			// context.getExternalContext().getRequestMap().get("lw");
			LessonWrapper lw2 = (LessonWrapper) getLessonLibrary().getRowData();

			// storeBeanFromFacesContext("CurrentLesson",context, lw2.getLesson());
			getBrainSession().setCurrentLesson(lw2.getLesson());
			RequestContext rc = RequestContext.getCurrentInstance();

			UIComponent ot1 = context.getViewRoot().findComponent("ot1");

			rc.addPartialTarget(ot1);

		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return null;
	}

	// public String learnLesson() {
	// getBrainSession().learnLesson();
	// return "userLesson";
	// }

	public String confLesson() {
		debug("bs: selectUserLesson... ");
		FacesContext context = FacesContext.getCurrentInstance();
		IUserLesson userLesson = (IUserLesson) context.getExternalContext().getRequestMap().get("userlesson");
		// storeBeanFromFacesContext("CurrentUserLesson",context, userLesson);
		getBrainSession().setCurrentUserLesson(userLesson);

		return "confLesson";
	}

	public String knowAnswer() {
		log.debug("knowAnswer");
		FacesContext context = FacesContext.getCurrentInstance();
		log.debug("context: " + context);
		BrainSession session = getBrainSession();
		UserItem userItem = session.getCurrentUserItem();

		try {
			userItem.knowAnswer();
			session.setLastUserItem(userItem);
			session.setLastAnswerText();
			getNextUserItem();
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		session.setAnswerText("<ohne Eingabe>");
		log.debug("correct");

		return "lesson";
	}

	public String failAnswer() {
		UserItem userItem = getBrainSession().getCurrentUserItem();
		BrainSession session = getBrainSession();

		try {
			userItem.failAnswer();
			getNextUserItem();
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		session.setAnswerText("<ohne Eingabe>");
		log.debug("wrong");

		return "lesson";
	}

	public String getNextItem() {
		try {
			getNextUserItem();
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "lesson";
	}

	public String editItem() {
		FacesContext context = FacesContext.getCurrentInstance();
		BrainSession session = getBrainSession();

		try {
			ListDataModel ldm = session.getItemList();
			log.debug("LDM: " + ldm);
			Item item = (Item) ldm.getRowData();
			Integer ri = (Integer) context.getExternalContext().getRequestMap().get("rowIndex");
			log.debug("editItem: " + item.getId() + " - " + item.getText() + " (" + ri.toString() + ")");
			item.modify();
			// storeBeanFromFacesContext("CurrentItem",context, item);
			getBrainSession().setCurrentItem(item);
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "edititem";
	}

	public String editNewItem() {
		try {
			Item item = new Item(getCurrentLesson());
			item.modify();
			// storeBeanFromFacesContext("CurrentItem",context, item);
			getBrainSession().setCurrentItem(item);
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "newitem";
	}

	public String deleteItem() {
		BrainSession session = getBrainSession();

		try {
			Item item = (Item) session.getItemList().getRowData();
			item.delete();
			session.loadItemList(true);
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "editlesson";
	}

	public String editLesson() {
		LessonWrapper lw2 = (LessonWrapper) getLessonLibrary().getRowData();

		log.debug("Edit Lesson: " + lw2.getLesson().getDescription());

		try {
			// userItem.editItem();
			// storeBeanFromFacesContext("CurrentLesson",context, lw2.getLesson());
			getBrainSession().setCurrentLesson(lw2.getLesson());

			BrainSession session = getBrainSession();
			session.loadItemList(true);
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "editlesson";
	}

	public String deleteLesson() {
		LessonWrapper lw2 = (LessonWrapper) getLessonLibrary().getRowData();

		log.debug("Delete Lesson: " + lw2.getLesson().getDescription());

		try {

			BrainSystem bs = BrainSystem.getBrainSystem();
			bs.getBrainDB().deleteLesson(lw2.getLesson());

			BrainSession session = getBrainSession();
			session.unloadLibrary();

		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "";
	}

	public String editNews() {
		FacesContext context = FacesContext.getCurrentInstance();

		try {
			ListDataModel ldm = getAllNews();
			log.debug("LDM: " + ldm);
			News news = (News) ldm.getRowData();
			Integer ri = (Integer) context.getExternalContext().getRequestMap().get("rowIndex");
			log.debug("editNews: " + news.getId() + " - " + news.getTitle() + " (" + ri.toString() + ")");
			news.modify();
			getBrainSession().setCurrentNews(news);
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "editnews";
	}

	public String addNews() {
		try {
			News news = new News();
			news.modify();
			getBrainSession().setCurrentNews(news);
			allnews = null;
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "editnews";
	}

	public String listAllItems() {
		try {
			BrainSession session = getBrainSession();
			session.loadItemList(true);
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "editlesson";
	}

	public String deactivateCurrentItem() {
		IUserLesson userLesson = getBrainSession().getCurrentUserLesson();
		try {
			userLesson.deactivateCurrentItem();
			getNextUserItem();
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "lesson";
	}

	/**
	 * @return
	 */
	public String storeComment() {
		BrainSession session = getBrainSession();
		UserItem userItem = getBrainSession().getCurrentUserItem();
		try {
			userItem.storeComment(session.getComment(), session.getCommentType());
			session.clearComment();
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return null;
	}

	public String forceAnswer() {
		BrainSession session = getBrainSession();
		UserItem userItem = getBrainSession().getCurrentUserItem();
		try {
			userItem.forceAnswer();
			session.setLastUserItem(userItem);
			session.setLastAnswerText();
			getNextUserItem();
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}
		return "lesson";
	}

	public String checkAnswerText() {
		String ret = "wrong";
		BrainSession session = getBrainSession();
		UserItem userItem = getBrainSession().getCurrentUserItem();
		debug("bs checkAnswerText:" + session.getAnswerText());

		// if (answerText.length() > 0) {
		try {
			if (userItem.checkAnswerText(session.getAnswerText())) {
				ret = "correct";
				session.setLastUserItem(userItem);
				session.setLastAnswerText();
				getNextUserItem();
			} else {
				session.setLastUserItem(null);
				markedText = findLongestCommonString(userItem.getItem(), session.getAnswerText());
			}
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}
		// }
		return ret;
	}

	public String leaveMessage() {
		BrainSession session = getBrainSession();

		User user = getBrainSession().getCurrentUser();

		String emailSubjectTxt = "Message from " + user.getName();
		String emailMsgTxt = session.getMessage();
		session.setMessage("");

		SendMailUsingAuthentication.sendConfirmationMail("info@notonto.de", emailSubjectTxt, emailMsgTxt);

		return "user";
	}

	private void getNextUserItem() throws DBException {
		BrainSession session = getBrainSession();
		session.setAnswerText("");
		markedText = "";
		IUserLesson userLesson = getBrainSession().getCurrentUserLesson();
		userLesson.getNextUserItem();
	}

	// action mit der getestet wird, ob schon eine Karte verfügbar ist.
	// So kann man die Zeit runterlaufen lassen.
	public String tryNextUserItem() throws DBException {
		getNextUserItem();
		return null;
	}

	public String loadUsers() {
		File dbfile = new File(brainHomeDir + "/users.xml");
		Administration.loadDB(dbfile);
		return "ok";
	}

	public void setBreakTime(int ibreakLevel, String breakTime) {

		if ((ibreakLevel >= 0) && (ibreakLevel < 10)) {
			breakTimes[ibreakLevel] = breakTimeInMillies(breakTime);
			debug("breakTimes: " + breakTimes[ibreakLevel]);
		}
	}

	/**
	 * Wandelt die Unterbrechungszeit in Textform in Millisekunden um. Erlaubt ist
	 * eine Zahl mit einem Kenner am Ende: M=Minutes, H=Hours, D=Days
	 * 
	 * @param breakTime
	 *          Unterbrechungszeit in Textform
	 * @return Zeit in Millisekunden
	 */
	public static long breakTimeInMillies(String breakTime) {
		long ret = 0;
		if (breakTime == null)
			return 0;
		if (breakTime.length() == 0)
			return 0;

		if (breakTime.length() == 1) {
			return 0;
		} else {
			String mark = breakTime.substring(breakTime.length() - 1);
			String time = breakTime.substring(0, breakTime.length() - 1);
			long ltime = Long.parseLong(time);

			if (mark.equals("M"))
				ret = 60 * 1000;
			else if (mark.equals("H"))
				ret = 60 * 60 * 1000;
			else if (mark.equals("D"))
				ret = 24 * 60 * 60 * 1000;
			else
				ret = 1000;

			ret = ret * ltime;
		}

		return ret;
	}

	/**
	 * Liefert die Unterbrechungszeit in Millisekunden für den angegebenen Level
	 * 
	 * @param level
	 * @return
	 */
	public long getBreakTime(int level) {
		return breakTimes[level];
	}

	public void setMaxItemsLevel0(int i) {
		maxItemsLevel0 = i;
	}

	public int getMaxItemsLevel0() {
		return maxItemsLevel0;
	}

	public String getCtx() {
		FacesContext context = FacesContext.getCurrentInstance();
		Object o = context.getViewRoot();
		return "[" + o + "]";
	}

	public String getMarkedText() {
		return markedText;
	}

	public void setMarkedText(String markedText) {
		this.markedText = markedText;
	}

	public String getRegisterText() {
		return registerText;
	}

	public String getReminderText() {
		return "Your password is @PASSWORD@ .";
	}

	public String getLocalFileName() {
		return localFileName;
	}

	public void setLocalFileName(String localFileName) {
		this.localFileName = localFileName;
	}

	public static Object accessBeanFromFacesContext(final String theBeanName, final FacesContext theFacesContext) {
		final Object returnObject = theFacesContext.getELContext().getELResolver().getValue(theFacesContext.getELContext(), null, theBeanName);
		if (returnObject == null) {
			log.error("Bean with name " + theBeanName + " was not found. Check the faces-config.xml file if the given bean name is ok.");
		}
		return returnObject;
	}

	public String getContext() {
		return this.toString();
	}

	public String getInvertLessonID() {
		return invertLessonID;
	}

	public void setInvertLessonID(String invertLessonID) {
		this.invertLessonID = invertLessonID;
	}

	public String loadLists() {
		return null;
	}

	public static String findLongestCommonString(Item item, String eingabe) {
		String ret = "";
		try {
			Vector<Answer> answers = item.getAnswers();

			Iterator<Answer> it = answers.iterator();
			double q = -1;

			StringUtils su = new StringUtils();

			while (it.hasNext()) {
				StringBuffer buf = new StringBuffer();
				Answer answer = it.next();
				double lq = su.longestCommonStrings(eingabe, answer.getText(), buf);
				log.debug("analyse: " + answer.getText() + "(" + lq + ")");
				if (lq > q) {
					ret = buf.toString();
					q = lq;
				}
			}

		} catch (Throwable t) {
			ret = eingabe;
			log.debug("EXC: longestCommonString");
			t.printStackTrace();
		}
		return ret;
	}

}
