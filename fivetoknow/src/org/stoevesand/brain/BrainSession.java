package org.stoevesand.brain;

import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.Vector;

import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.faces.model.ListDataModel;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.jfree.data.time.Day;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.jfree.data.xy.XYDataset;
import org.stoevesand.brain.auth.User;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.brain.model.IUserLesson;
import org.stoevesand.brain.model.Item;
import org.stoevesand.brain.model.Lesson;
import org.stoevesand.brain.model.UserItem;
import org.stoevesand.brain.persistence.BrainDB;
import org.stoevesand.util.News;

public class BrainSession {

	private static final String CAT_SELECTION = "mode_sel_cat";
	private static final int CAT_SIZES = 3;

	private static Logger log = Logger.getLogger(BrainSession.class);

	private boolean loggedIn = false;

	public boolean isLoggedIn() {
		return loggedIn;
	}

	private ListDataModel itemList = null;
	private UserItem lastUserItem = null;

	private String answerText = "";

	private String message = "";

	private String comment = "";
	private String commentType = "";

	private String filterText = "";
	private String filterCat = "";
	private String lessonCode = "";

	private int loginAttempts = 0;
	private int encoding = 0;
	private int fileFormat = 1; // default: Excel

	private final Locale LOCALE_DE = new Locale("de", "DE");
	private final Locale LOCALE_ES = new Locale("es", "ES");
	private final Locale LOCALE_EN = new Locale("en", "EN");

	// Kategorie der Sprache für die WordPress Anbindung
	private int wpCategory = 3;

	public int getWpCategory() {
		return wpCategory;
	}

	private ResourceBundle resourceBundle = null;

	public Locale currentLocale = LOCALE_DE;

	Vector<Category> localCategories = null;

	private Topic rootTopic = null;
	Topic currentTopic = null;

	// String libLanguage = null;

	HashMap<String, String> parameters = new HashMap<String, String>(5);

	/**
	 * Former Managed Beans
	 */
	User currentUser = null;
	UserItem currentUserItem = null;
	IUserLesson currentUserLesson = null;
	Lesson currentLesson = null;
	Item currentItem = null;
	News currentNews = null;

	LessonLoader lessonLoader = new LessonLoader();

	public LessonLoader getLessonLoader() {
		return lessonLoader;
	}

	public BrainSession() {
		FacesContext context = FacesContext.getCurrentInstance();
		ServletRequest request = (ServletRequest) context.getExternalContext().getRequest();
		String servername = request.getServerName();

		if ("www.notonto.com".equals(servername)) {
			currentLocale = LOCALE_EN;
			wpCategory = 4; // wordpres category "deutsch"
		} else if ("localhost".equals(servername)) {
			currentLocale = LOCALE_EN;
			wpCategory = 4; // wordpres category "deutsch"
		} else {
			currentLocale = LOCALE_DE;
			wpCategory = 3; // wordpres category "deutsch"
		}
		loadResourceBundle();
		loadTopics();
		// libLanguage = null; // currentLocale.getLanguage();
	}

	public String localeDE() {
		currentLocale = LOCALE_DE;
		localCategories = null;
		loadTopics();
		loadResourceBundle();
		unloadLibrary();
		wpCategory = 3; // wordpres category "deutsch"
		return "index";
	}

	public String localeES() {
		currentLocale = LOCALE_ES;
		localCategories = null;
		loadTopics();
		loadResourceBundle();
		unloadLibrary();
		wpCategory = 3; // wordpres category "deutsch"
		return "index";
	}

	public String localeEN() {
		currentLocale = LOCALE_EN;
		localCategories = null;
		loadTopics();
		loadResourceBundle();
		unloadLibrary();
		wpCategory = 4; // wordpres category "english"
		return "index";
	}

	public BrainMessage getBrainMessage() {

		FacesContext context = FacesContext.getCurrentInstance();
		BrainMessage brainMessage = (BrainMessage) BrainSystem.accessBeanFromFacesContext("BrainMessage", context);

		return brainMessage;
	}

	private String sortColumn = "";

	private int pageIndex = 0;

	public String getSortColumn() {
		return sortColumn;
	}

	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public ListDataModel getItemList() {

		if (itemList == null) {
			log.debug("loadItemList.");
			loadItemList(false);
		}

		// log.debug("Session:" + this);
		// log.debug("LDM1: " + itemList);

		return itemList;
	}

	public void loadItemList(boolean fullReload) {
		Lesson lesson = getCurrentLesson();

		log.debug("CurrentLesson: " + lesson.getDescription());
		if (fullReload)
			lesson.loadItems();
		itemList = new ListDataModel(lesson.getFilteredItems(filterText));
		pageIndex = 0;
	}

	public int getPageIndex() {
		log.debug("getI:" + pageIndex);
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex - (pageIndex % numRows);
		log.debug("setI:" + pageIndex);
	}

	int numRows = 10;

	private String lastAnswerText = "";

	public int getNumRows() {
		return numRows;
	}

	public void setNumRows(int numRows) {
		this.numRows = numRows;
	}

	public void setLastUserItem(UserItem userItem) {
		this.lastUserItem = userItem;

	}

	public UserItem getLastUserItem() {
		return this.lastUserItem;
	}

	public String getCommentType() {
		return commentType;
	}

	public void setCommentType(String commentType) {
		this.commentType = commentType;
	}

	public String clearComment() {
		this.comment = "";
		this.commentType = "";
		return null;
	}

	public void setLastAnswerText() {
		this.lastAnswerText = answerText;
	}

	public String getLastAnswerText() {
		return lastAnswerText;
	}

	ListDataModel library = null;
	ListDataModel ownerLibrary = null;
	ListDataModel topics = null;
	ListDataModel topicPath = null;

	private void loadTopics() {
		rootTopic = BrainSystem.getBrainSystem().getBrainDB().getTopicTree(currentLocale.getLanguage());
		currentTopic = rootTopic;
		log.debug("ROOT: " + currentTopic.getText() + " - " + currentTopic.getId());
	}

	private Topic findTopic(long id) {
		return findTopic(rootTopic, id);
	}

	private Topic findTopic(Topic startTopic, long id) {
		if (startTopic.getId() == id)
			return startTopic;
		for (Topic topic : startTopic.getSubTopics()) {
			Topic resTopic = findTopic(topic, id);
			if (resTopic != null)
				return resTopic;
		}
		return null;
	}

	public Topic getRootTopic() {
		return rootTopic;
	}

	public ListDataModel getTopicPath() {

		selectCurrentTopic();

		Vector<Topic> tpp = new Vector<Topic>();
		if (currentTopic != null)
			currentTopic.getTopicPath(tpp);
		else
			rootTopic.getTopicPath(tpp);
		topicPath = new ListDataModel(tpp);
		return topicPath;
	}

	void selectCurrentTopic() {

		try {
			FacesContext context = FacesContext.getCurrentInstance();

			boolean cat = selectedByCategory();

			HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
			String uri = request.getRequestURI();

			int pos1 = uri.indexOf("topic_");

			if ((pos1 >= 0) && !cat) {
				int pos2 = uri.indexOf(".jsf");
				String sid = uri.substring(pos1 + 6, pos2);
				long id = Long.valueOf(sid);
				currentTopic = findTopic(id);
				filterCat = "";
			}
		} catch (Exception e) {
			log.error(e);
			currentTopic = rootTopic;
		}

		unloadLibrary();

	}

	private boolean selectedByCategory() {
		FacesContext context = FacesContext.getCurrentInstance();
		HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();

		// mit diesem attribut im request wird geprüft, ob über einen Request
		// Paramter (GET)
		// selektiert wurde
		String cat1 = request.getParameter("cat");
		if (cat1 != null) {
			cat1 = StringEscapeUtils.unescapeJava(cat1);
			setCategory(cat1);
			return true;
		}

		// mit diesem attribut im request wird geprüft, ob aus der tag cloud
		// selektiert wurde
		String cat2 = (String) request.getAttribute(CAT_SELECTION);

		return cat2 != null;
	}

	public ListDataModel getTopics() {

		selectCurrentTopic();

		if (currentTopic != null)
			topics = new ListDataModel(currentTopic.getSubTopics());
		else
			topics = new ListDataModel();
		return topics;
	}

	public int getTopicCount() {
		return topics == null ? 0 : topics.getRowCount();
	}

	public String selectPathTopic() {
		currentTopic = (Topic) topicPath.getRowData();
		unloadLibrary();
		filterCat = "";
		return null;
	}

	public String selectTopic() {
		currentTopic = (Topic) topics.getRowData();
		unloadLibrary();
		filterCat = "";
		return null;
	}

	public ListDataModel getLibrary() {
		if (library == null) {
			library = loadLibrary();
		}
		return library;
	}

	public void unloadLibrary() {
		library = null;
		ownerLibrary = null;
	}

	public ListDataModel loadLibrary() {

		selectCurrentTopic();

		log.debug("getLibrary.start.");
		Vector<Lesson> lessons;
		Vector<LessonWrapper> ret = new Vector<LessonWrapper>();
		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainDB brainDB = bs.getBrainDB();
		User cu = null;
		if (loggedIn)
			cu = getCurrentUser();
		try {
			if (currentTopic != null) {
				// auswahl nach Topic: Sprachen, Allgemeinbildung, ...
				lessons = brainDB.getLessons(currentTopic); // currentLocale.getLanguage()
			} else if ((lessonCode != null) && (lessonCode.length() > 1)) {
				// Auswahl nach dem Freischaltcode
				lessons = brainDB.getLessonsByCode(lessonCode);
			} else if ((filterCat != null) && (filterCat.length() > 1)) {
				// Auswahl nach der Kategorie (Tag Cloud)
				lessons = brainDB.getLessonsByFilter(filterCat);
			} else {
				// leere Liste erzeugen
				lessons = new Vector<Lesson>();
			}
			for (Lesson lesson : lessons) {
				LessonWrapper lw = new LessonWrapper();
				lw.lesson = lesson;
				if (cu != null) {
					lw.subscribed = cu.hasLesson(lesson);
					lw.owner = lesson.isOwner(cu); // cu.getName().equals("steffi");
				}
				ret.add(lw);
			}
		} catch (DBException e) {
			e.printStackTrace();
		}

		library = new ListDataModel(ret);
		log.debug("getLibrary.end.");
		return library;
	}

	/**
	 * function to initialise the Session after a user logged in
	 */
	public void login() {
		loggedIn = true;
		loadLibrary();
	}

	public String learnLesson() {
		FacesContext context = FacesContext.getCurrentInstance();
		IUserLesson userLesson = (IUserLesson) context.getExternalContext().getRequestMap().get("userlesson");
		log.debug("UserLesson: " + userLesson);
		try {
			learnLesson(userLesson);
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}
		return "userLesson";
	}

	public void learnLesson(IUserLesson userLesson) throws DBException {
		setCurrentUserLesson(userLesson);
		setLastUserItem(null);
		userLesson.getNextUserItem();
	}

	public String subscribeLesson() {
		try {
			//BrainSession bs = getBrainSession();

			LessonWrapper lw2 = (LessonWrapper) getLibrary().getRowData();
			User user = getCurrentUser();

			IUserLesson userLesson = null;
			if (lw2.getIsSubscribed())
				userLesson = user.getUserLessonByLessonID(lw2.lesson.getId());
			else
				userLesson = user.subscribeLesson(lw2.lesson);
			// storeBeanFromFacesContext("CurrentUserLesson",context, userLesson);
			setCurrentUserLesson(userLesson);

			userLesson.getNextUserItem();

			unloadLibrary();

			log.debug("bs: subscribeLesson -> " + lw2.lesson.getTitle());
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "lesson";
	}

	public String unsubscribeLesson() {
		try {
			log.debug("bs: unsubscribeLesson ...");
			FacesContext context = FacesContext.getCurrentInstance();
			IUserLesson iul = (IUserLesson) context.getExternalContext().getRequestMap().get("userlesson");
			User user = getCurrentUser();

			log.debug("bs: unsubscribeLesson -> " + iul);

			user.unsubscribeLesson(iul);
			unloadLibrary();
		} catch (DBException e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "user";
	}

	TimeSeriesCollection dataset = null;

	@SuppressWarnings("deprecation")
	public XYDataset getScoreDataset() {

		if (dataset == null) {

			TimeSeries s1 = new TimeSeries("Score", Day.class);

			BrainSystem bs = BrainSystem.getBrainSystem();
			BrainDB brainDB = bs.getBrainDB();

			try {
				brainDB.loadScoreHistory(s1, getCurrentUser());
			} catch (DBException e) {
				e.printStackTrace();
			}

			dataset = new TimeSeriesCollection();
			dataset.addSeries(s1);

			dataset.setDomainIsPointsInTime(true);
		}

		User cu = getCurrentUser();

		TimeSeries ts = dataset.getSeries(0);
		int r = ts.getItemCount() - 1;
		ts.delete(r, r);
		ts.add(new Day(new Date()), cu.getScore());

		return dataset;
	}

	public void setCategory(ActionEvent event) {
		String cat = (String) event.getComponent().getAttributes().get("cat");
		setCategory(cat);
	}

	private void setCategory(String cat) {

		// mit diesem attribut im request wird geprüft, ob aus der tag cloud
		// selektiert wurde
		HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
		request.setAttribute(CAT_SELECTION, "cat");

		if (!filterCat.equals(cat)) {
			unloadLibrary();
			filterCat = cat;
		}

		currentTopic = null;
		lessonCode = "";
	}

	public String selectLessonCode() {
		library = null;
		filterCat = "-";

		// mit diesem attribut im request wird geprüft, ob aus der tag
		// cloud/Lessoncode selektiert wurde
		HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
		request.setAttribute(CAT_SELECTION, "cat");

		return "lib";
	}

	public String getLessonCode() {
		return lessonCode;
	}

	public void setLessonCode(String lessonCode) {
		this.lessonCode = lessonCode;
		currentTopic = null;
	}

	public ListDataModel getLocalCategories() {
		if (localCategories == null) {
			loadLocalCategories();
		}
		return new ListDataModel(localCategories);
	}

	public void loadLocalCategories() {
		localCategories = new Vector<Category>();
		String lang = getCurrentLocale().getLanguage();

		// log.debug("C : " + lang);
		BrainSystem bs = BrainSystem.getBrainSystem();

		Vector<Category> categories = bs.getCategories();
		for (Category c : categories) {
			// log.debug("CL: " + c.getLocale());
			if (c.getLocale().equals(lang)) {
				localCategories.add(c);
			}
		}

		calculateCategorySize();

	}

	public void unloadLocalCategories() {
		localCategories = null;
	}

	private void calculateCategorySize() {
		// Vector<Category> cats = new Vector<Category>();

		Collections.sort(localCategories, new Comparator<Category>() {
			public int compare(Category o1, Category o2) {
				return (o1.getCount() > o2.getCount()) ? 1 : -1;
			}
		});

		int cat_count = localCategories.size();
		int cat_sizes = CAT_SIZES;
		int cat_slots = (cat_count / cat_sizes) + ((cat_count % cat_sizes) == 0 ? 0 : 1);
		int pos = 0;
		for (Category c : localCategories) {
			c.setSize(pos / cat_slots);
			pos++;
		}

		Collections.sort(localCategories, new Comparator<Category>() {
			public int compare(Category o1, Category o2) {
				return (o1.getText().compareTo(o2.getText()));
			}
		});

	}

	public String getFilterText() {
		return filterText;
	}

	public void setFilterText(String text) {
		if (!this.filterText.equals(text)) {
			itemList = null;
			pageIndex = 0;
			this.filterText = text;
		}
	}

	public String getFilterCat() {
		return filterCat;
	}

	public void setFilterCat(String filterCat) {
		this.filterCat = filterCat;
	}

	public Locale getCurrentLocale() {
		return currentLocale;
	}

	public void loadResourceBundle() {
		resourceBundle = ResourceBundle.getBundle("org.stoevesand.brain.i18n.MessagesBundle", currentLocale);
	}

	public void incrementLoginCounter() {
		loginAttempts++;
	}

	public int getLoginAttempts() {
		return loginAttempts;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getAnswerText() {
		return answerText;
	}

	public void setAnswerText(String answerText) {
		this.answerText = answerText;
	}

	public User getCurrentUser() {
		return currentUser;
	}

	public void setCurrentUser(User currentUser) {
		this.currentUser = currentUser;
	}

	public Item getCurrentItem() {
		return currentItem;
	}

	public void setCurrentItem(Item currentItem) {
		this.currentItem = currentItem;
	}

	public News getCurrentNews() {
		return currentNews;
	}

	public void setCurrentNews(News currentNews) {
		this.currentNews = currentNews;
	}

	public void setCurrentLocale(Locale currentLocale) {
		this.currentLocale = currentLocale;
	}

	public UserItem getCurrentUserItem() {
		return currentUserItem;
	}

	public void setCurrentUserItem(UserItem currentUserItem) {
		this.currentUserItem = currentUserItem;
	}

	public IUserLesson getCurrentUserLesson() {
		return currentUserLesson;
	}

	public void setCurrentUserLesson(IUserLesson currentUserLesson) {
		this.currentUserLesson = currentUserLesson;
	}

	// bei einem direkteinstieg kann die aktuelle UserLesson so gewählt werden
	// der Parameter ulid wird dann aus der JSP übergeben
	public boolean setCurrentUserLesson(String sulid) {
		boolean ret=true;
		try {
			User user = getCurrentUser();
			System.out.println("U: "+user);
			if (user != null) {
				long ulid = Long.parseLong(sulid);
				IUserLesson userLesson = user.getUserLesson(ulid);
				System.out.println("LOAD: "+userLesson);
				if (userLesson != null)
					learnLesson(userLesson);
				else
					ret=false;
			}
		} catch (Exception e) {
			System.out.println("exc: "+e);
			ret=false;
		}
		return ret;
	}

	public Lesson getCurrentLesson() {
		return currentLesson;
	}

	public void setCurrentLesson(Lesson currentLesson) {
		this.currentLesson = currentLesson;
	}

	public ResourceBundle getResourceBundle() {
		return resourceBundle;
	}

	public Topic getCurrentTopic() {
		return currentTopic;
	}

	public Topic getCurrentTopicDirect() {
		selectCurrentTopic();
		return currentTopic;
	}

	public String downloadLesson() {

		lessonLoader.downloadLesson(getCurrentLesson());

		return null;
	}

	public String fileLessonUploaded() {
		System.out.println("uploaded new entries.");

		if (lessonLoader.fileLessonUploaded(this, getCurrentLesson())) {
			// force a reload of all items after the upload
			getCurrentLesson().reset();

			// unload the library
			unloadLibrary();
			itemList = null;
		}

		return "validateUpload";
	}

	public String confirmNewItems() {

		log.debug("confirm new items.");

		lessonLoader.confirmNewItems();

		addItemToUserLesson();

		return "editlessonmeta";
	}

	private void addItemToUserLesson() {
		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainDB brainDB = bs.getBrainDB();

		try {
			Vector<IUserLesson> userLessons = brainDB.getUserLessons(currentLesson);
			for (IUserLesson userLesson : userLessons) {
				log.debug("activate extra item ULID: " + userLesson.getId());
				brainDB.activateUserItemExp(userLesson);
			}
		} catch (DBException e) {
			e.printStackTrace();
		}

	}

	// void readNewItemsText(InputStream inputStream) {
	//
	// HashMap<String, Item> items = new HashMap<String, Item>();
	// try {
	//
	// // InputSource is = new InputSource(inputStream);
	// // is.setEncoding("utf-8");
	// String line = "";
	// String pattern = "QAAA";
	//
	// InputStreamReader isr = new InputStreamReader(inputStream, (encoding == 0)
	// ? "iso-8859-1" : "utf-8");
	// // InputStreamReader isr = new InputStreamReader(inputStream);
	// BufferedReader br = new BufferedReader(isr);
	// line = br.readLine();
	// line = trimBOM(line);
	// if (line.substring(0, 1).equals("!")) {
	// pattern = line.substring(1);
	// line = br.readLine();
	// }
	// while (line != null) {
	// String[] split = line.split("\t");
	// Item item = new Item();
	// item.setLessonId(currentLesson.getId());
	// item.setChapter(currentLesson.getHighestChapter() + 1);
	//
	// for (int i = 0; i < pattern.length(); i++) {
	// switch (pattern.charAt(i)) {
	// case 'Q':
	// item.setText(readToken(split, i));
	// break;
	// case 'C':
	// item.setComment(readToken(split, i));
	// break;
	// case 'E':
	// item.setExtId(readLongToken(split, i));
	// break;
	// case 'A':
	// String at = readToken(split, i);
	// if (at != null) {
	// Answer answer = new Answer(at, true, 0);
	// item.addAnswer(answer);
	// }
	// break;
	// default:
	// log.debug("Unknown import type: " + pattern.charAt(i));
	// }
	// }
	// Item i2 = items.get(item.getText());
	// if (i2 != null) {
	// i2.getAnswers().addAll(item.getAnswers());
	// item = i2;
	// }
	// items.put(item.getText(), item);
	// line = br.readLine();
	// }
	//
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// newItems = new Vector<Item>(items.values());
	// }

	String trimBOM(String line) {
		byte[] bl = line.getBytes();
		if ((bl[0] == -17) && (bl[1] == -69) && (bl[2] == -65)) {
			line = line.substring(1);
		}
		// System.out.println("0: " + Character.toString((char)bl[0]));
		// System.out.println("1: " + Byte.toString(bl[1]));
		// System.out.println("2: " + Byte.toString(bl[2]));
		// byte[] bom = new byte[3];
		// bom[0] = (byte) 0xEF; -17
		// bom[1] = (byte) 0xBB; -69
		// bom[2] = (byte) 0xBF; -65
		return line;
	}

	String readToken(String[] field, int pos) {
		if (field.length > pos)
			return field[pos];
		return null;
	}

	long readLongToken(String[] field, int pos) {
		long ret = 0;
		if (field.length > pos) {
			String s = field[pos];
			try {
				ret = Long.parseLong(s);
			} catch (Exception e) {
				log.error("not a valid extid: " + s);
			}
		}
		return ret;
	}

	public ListDataModel getOwnerLibrary() {
		if (ownerLibrary == null)
			loadOwnerLibrary();
		return ownerLibrary;
	}

	public void setOwnerLibrary(ListDataModel ownerLibrary) {
		this.ownerLibrary = ownerLibrary;
	}

	public ListDataModel loadOwnerLibrary() {

		log.debug("getOwnerLibrary.start.");
		Vector<Lesson> lessons;
		Vector<LessonWrapper> ret = new Vector<LessonWrapper>();
		BrainSystem bs = BrainSystem.getBrainSystem();
		BrainDB brainDB = bs.getBrainDB();
		User cu = null;
		if (loggedIn)
			cu = getCurrentUser();
		try {
			lessons = brainDB.getOwnerLessons(cu); // currentLocale.getLanguage()
			for (Lesson lesson : lessons) {
				LessonWrapper lw = new LessonWrapper();
				lw.lesson = lesson;
				if (cu != null) {
					lw.subscribed = cu.hasLesson(lesson);
					lw.owner = lesson.isOwner(cu); // cu.getName().equals("steffi");
					lw.group = lesson.isGroup(cu);
				}
				ret.add(lw);
			}
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ownerLibrary = new ListDataModel(ret);
		log.debug("getLibrary.end.");
		return ownerLibrary;
	}

	public String editOwnerLesson() {
		if (ownerLibrary != null) {
			LessonWrapper lw2 = (LessonWrapper) ownerLibrary.getRowData();
			log.debug("Edit Owner Lesson: " + lw2.getLesson().getDescription());

			try {
				// userItem.editItem();
				// storeBeanFromFacesContext("CurrentLesson",context, lw2.getLesson());
				setCurrentLesson(lw2.getLesson());

				loadItemList(true);
			} catch (Exception e) {
				e.printStackTrace();
				return "fatal_DB";
			}

			return "editlessonmeta";
		} else {
			log.error("OwnerLesson is null.");
		}
		return null;
	}

	public String deleteOwnerLesson() {
		try {
			BrainSystem bs = BrainSystem.getBrainSystem();
			bs.getBrainDB().deleteLesson(getCurrentLesson());
			unloadLibrary();
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}
		setOwnerLibrary(null);
		return "lessonlist";

	}

	public String newLesson() {
		try {
			Lesson lesson = new Lesson();
			User cu = null;
			if (loggedIn)
				cu = getCurrentUser();
			lesson.setOwner(cu);
			lesson.modify();
			setCurrentLesson(lesson);
			setOwnerLibrary(null);
			itemList = null;
		} catch (Exception e) {
			e.printStackTrace();
			return "fatal_DB";
		}

		return "newlesson";
	}

	public String saveCurrentItem() {
		String ret = "ok";
		try {
			getCurrentItem().saveAction();
			itemList = null;
		} catch (DBException e) {
			e.printStackTrace();
		}
		return ret;
	}

	public int getEncoding() {
		return encoding;
	}

	public void setEncoding(int encoding) {
		this.encoding = encoding;
	}

	public int getFileFormat() {
		return fileFormat;
	}

	public void setFileFormat(int fileFormat) {
		this.fileFormat = fileFormat;
	}

	public void putParameter(String key, String value) {
		parameters.put(key, value);
	}

	public String getParameter(String key) {
		return parameters.get(key);
	}

	public String subscribeOwnerLesson() {
		if (ownerLibrary != null) {
			try {
				LessonWrapper lw2 = (LessonWrapper) ownerLibrary.getRowData();
				User user = getCurrentUser();

				IUserLesson userLesson = null;
				if (lw2.getIsSubscribed())
					userLesson = user.getUserLessonByLessonID(lw2.lesson.getId());
				else
					userLesson = user.subscribeLesson(lw2.lesson);
				// storeBeanFromFacesContext("CurrentUserLesson",context, userLesson);
				setCurrentUserLesson(userLesson);

				userLesson.getNextUserItem();

				unloadLibrary();

			} catch (DBException e) {
				e.printStackTrace();
				return "fatal_DB";
			}

			return "lesson";
		} else {
			log.error("OwnerLesson is null.");
		}
		return null;

	}

	public String confIntervals() {
		log.debug("bs: conf Intervals... ");
		FacesContext context = FacesContext.getCurrentInstance();
		IUserLesson userLesson = (IUserLesson) context.getExternalContext().getRequestMap().get("userlesson");
		// storeBeanFromFacesContext("CurrentUserLesson",context, userLesson);
		setCurrentUserLesson(userLesson);

		return "confIntervals";
	}

}
