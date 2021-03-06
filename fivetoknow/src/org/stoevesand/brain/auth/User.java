package org.stoevesand.brain.auth;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Iterator;
import java.util.Vector;

import org.jboss.logging.Logger;
import org.stoevesand.brain.BrainSystem;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.brain.model.IUserLesson;
import org.stoevesand.brain.model.Lesson;
import org.stoevesand.brain.persistence.BrainDB;
import org.stoevesand.util.DBUtil;

public class User {
	private static Logger log = Logger.getLogger(User.class);

	final static int USER_TYPE_ADMIN = 9;
	final static int USER_TYPE_TEACHER = 7;
	final static int USER_TYPE_USER = 0;

	String name = "";
	String nick = null;
	String password = "";
	String unlockString = "";
	String statusLang = "de";
	String prefix = "";

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	boolean unlocked = false;
	// Vector<UserLesson> lessons = null;
	long id = 0;
	long groupID = 0;
	short type = 0;

	int statusMailFreq = 0;

	public int getStatusMailFreq() {
		return statusMailFreq;
	}

	public void setStatusMailFreq(int statusMailFreq) {
		this.statusMailFreq = statusMailFreq;
	}

	Date registerDate = null;
	Date lastLoginDate = null;

	boolean dirty = false;

	public User() {
	}

	public User(long id, String name) {
		this.id = id;
		this.name = name;
		this.type = USER_TYPE_USER;
	}

	public User(String name, String password, String unlockString, boolean unlocked) {
		this.id = -1;
		this.name = name;
		this.password = password;
		this.unlockString = unlockString;
		this.unlocked = unlocked;
		this.registerDate = new Date();
		this.type = USER_TYPE_USER;
		dirty = true;
	}

	public void store() throws DBException {
		if (dirty) {
			BrainDB db = BrainSystem.getBrainSystem().getBrainDB();
			db.addUser(this);
		}
		dirty = false;
	}

	public void unlock() throws DBException {
		BrainDB db = BrainSystem.getBrainSystem().getBrainDB();
		db.unlockUser(this);
	}

	public User(ResultSet rs) throws SQLException {
		this.id = DBUtil.getLong(rs, "id");
		this.name = DBUtil.getString(rs, "name");
		this.nick = DBUtil.getString(rs, "nick");
		this.password = DBUtil.getString(rs, "password");
		this.unlockString = DBUtil.getString(rs, "unlocktext");
		this.unlocked = DBUtil.getBoolean(rs, "unlocked");
		this.registerDate = DBUtil.getTimestamp(rs, "register_date");
		this.lastLoginDate = DBUtil.getTimestamp(rs, "lastlogin_date");
		this.type = DBUtil.getShort(rs, "usertype");
		this.groupID = DBUtil.getLong(rs, "groupID");
		this.statusMailFreq = DBUtil.getInt(rs, "newsletter");
		this.statusLang = DBUtil.getString(rs, "status_lang");
		this.prefix = DBUtil.getString(rs, "prefix");
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
	}

	public boolean getUnlocked() {
		return unlocked;
	}

	Vector<IUserLesson> userLessons = null;

	public Vector<IUserLesson> getLessons() {
		try {
			if (userLessons == null)
				userLessons = BrainSystem.getBrainSystem().getBrainDB().getUserLessons(this);
		} catch (DBException e) {
			e.printStackTrace();
		}
		return userLessons;
	}

	public IUserLesson subscribeLesson(Lesson lesson) throws DBException {
		IUserLesson ret = null;
		// UserLesson userLesson =
		BrainSystem bs = BrainSystem.getBrainSystem();
		ret = bs.getBrainDB().subscribeLesson(this, lesson);
		// lessons.add(userLesson);
		bs.getBrainSession().loadLibrary();
		userLessons = null;
		return ret;
	}

	public boolean getIsAdmin() {
		return (type == USER_TYPE_ADMIN);
	}

	public boolean getIsTeacher() {
		return (type == USER_TYPE_ADMIN) || (type == USER_TYPE_TEACHER);
	}

	public void unsubscribeLesson(IUserLesson lesson) throws DBException {
		// UserLesson userLesson =
		BrainSystem bs = BrainSystem.getBrainSystem();
		bs.getBrainDB().unsubscribeLesson(this, lesson);
		// lessons.add(userLesson);
		bs.getBrainSession().loadLibrary();
		userLessons = null;
	}

	public void unsubscribeLesson(Lesson lesson) throws DBException {
		// UserLesson userLesson =
		BrainSystem bs = BrainSystem.getBrainSystem();
		bs.getBrainDB().unsubscribeLesson(this, lesson);
		// lessons.add(userLesson);
		bs.getBrainSession().loadLibrary();
		userLessons = null;
	}

	public int getAvailable() {
		int ret = 0;
		try {
			ret = BrainSystem.getBrainSystem().getBrainDB().getUserAvailable(this);
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ret;
	}

	public int getScore() {
		int ret = 0;
		try {
			ret = BrainSystem.getBrainSystem().getBrainDB().getUserScore(this);
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ret;
	}

	// TODO: schlechter code, besser gleich an die DB
	public boolean hasLesson(Lesson lesson) {
		try {
			Vector<IUserLesson> lessons = getLessons();
			Iterator<IUserLesson> it = lessons.iterator();
			while (it.hasNext()) {
				IUserLesson userLesson = it.next();
				if (userLesson.getLesson().getId() == lesson.getId())
					return true;
			}
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public IUserLesson getUserLesson(long ulid) {
		IUserLesson userLesson = null;
		try {
			BrainSystem bs = BrainSystem.getBrainSystem();
			userLesson = bs.getBrainDB().getUserLesson(this, ulid);
		} catch (DBException e) {
			e.printStackTrace();
		}
		return userLesson;
	}

	public IUserLesson getUserLessonByLessonID(long lid) {
		IUserLesson userLesson = null;
		try {
			BrainSystem bs = BrainSystem.getBrainSystem();
			userLesson = bs.getBrainDB().getUserLessonByLessonID(this, lid);
		} catch (DBException e) {
			e.printStackTrace();
		}
		return userLesson;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUnlock() {
		return unlockString;
	}

	public void storeScore() throws DBException {
		BrainSystem.getBrainSystem().getBrainDB().storeUserScore(this, getScore());
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public Date getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public void storeLastLogin() throws DBException {
		lastLoginDate = new Date();
		BrainSystem.getBrainSystem().getBrainDB().storeLastLogin(this);
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public long getGroupID() {
		return groupID;
	}

	public void setGroupID(long groupID) {
		this.groupID = groupID;
	}

	public String getStatusLang() {
		return statusLang;
	}

	public void setStatusLang(String statusLang) {
		this.statusLang = statusLang;
	}

}
