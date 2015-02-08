package org.stoevesand.brain.model;

import java.sql.ResultSet;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.jboss.logging.Logger;
import org.stoevesand.brain.BrainMessage;
import org.stoevesand.brain.BrainSession;
import org.stoevesand.brain.BrainSystem;
import org.stoevesand.brain.UserLessonConfig;
import org.stoevesand.brain.UserStats;
import org.stoevesand.brain.auth.User;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.util.DBUtil;

@XmlRootElement(name = "userlesson")
public abstract class UserLesson implements IUserLesson {

	/*
	 * Neue Spalten:
	 */

	private static Logger log = Logger.getLogger(UserLesson.class);

	@XmlElement
	long id = 0;

	long userId = 0;
	long lessonId = 0;

	boolean dirty = false;

	/**
	 * 0=standard, 1=Zieltermin
	 */
	short intervallType = 0; // 0=standard 1=Zieltermin
	String targetDate = "";

	public String getTargetDate() {
		return realTargetDate != null ? DateFormatUtils.format(realTargetDate, "dd.MM.yyyy") : "";
	}

	public void setTargetDate(String targetDate) {
		this.targetDate = targetDate;
	}

	public short getIntervallType() {
		return intervallType;
	}

	public void setIntervallType(short intervallType) {
		if (this.intervallType != intervallType)
			dirty = true;
		this.intervallType = intervallType;
	}

	private Lesson lesson = null;

	UserItem currentUserItem = null;
	UserStats userStats = null;
	UserLessonConfig config = new UserLessonConfig(this);

	// String breakTimeText = null;
	long breakTimes[] = new long[10];

	private long intervallUnit;

	public long getIntervallUnit() {
		return intervallUnit;
	}

	private Date realTargetDate;

	public Date getRealTargetDate() {
		return realTargetDate;
	}

	@XmlElement
	public UserLessonConfig getConfig() {
		return config;
	}

	UserLesson() {
		userStats = new UserStats(this);
	}

	public UserLesson(ResultSet rs) {
		this.id = DBUtil.getLong(rs, "ulid");
		this.lessonId = DBUtil.getLong(rs, "lessonID");
		this.userId = DBUtil.getLong(rs, "userID");
		this.intervallUnit = DBUtil.getLong(rs, "interval_unit");
		this.realTargetDate = DBUtil.getDate(rs, "target_date");
		this.intervallType = DBUtil.getShort(rs, "intervall_type");
		calcBreakTimes();
		userStats = new UserStats(this);
	}

	public UserStats getUserStats() {
		return userStats;
	}

	public long getId() {
		return id;
	}

	@XmlElement
	public Lesson getLesson() throws DBException {
		if (lesson == null)
			lesson = BrainSystem.getBrainSystem().getBrainDB().getLesson(lessonId);
		return lesson;
	}

	public void deactivateCurrentItem() throws DBException {
		currentUserItem.deactivate();
		activateUserItem();
	}

	public void activateUserItem() throws DBException {
		BrainSystem.getBrainSystem().getBrainDB().activateUserItemExp(this);
		userStats.invalidate();
	}

	public UserItem getCurrentUserItem() {
		return currentUserItem;
	}

	// public String knowAnswer() {
	// }

	public User getUser() throws DBException {
		return BrainSystem.getBrainSystem().getBrainDB().getUser(userId);
	}

	public int getAvailable() throws DBException {
		// return userStats.getAvailable();
		return BrainSystem.getBrainSystem().getBrainDB().getUserLessonAvailable(this);
	}

	public int getLevel0() throws DBException {
		return userStats.getLevel0(this);
	}

	public int getLevel1() throws DBException {
		return userStats.getLevel1(this);
	}

	public int getLevel2() throws DBException {
		return userStats.getLevel2(this);
	}

	public int getLevel3() throws DBException {
		return userStats.getLevel3(this);
	}

	public int getLevel4() throws DBException {
		return userStats.getLevel4(this);
	}

	public int getLevel5() throws DBException {
		return userStats.getLevel5(this);
	}

	public int getScore() throws DBException {
		return userStats.getScore();
	}

	public String saveIntervalls() {
		String ret = "user";
		if (intervallType == 0) {
			targetDate = "";
			realTargetDate = null;
			if (dirty)
				store();
		} else {
			BrainSession bss = BrainSystem.getBrainSystem().getBrainSession();
			BrainMessage msg = bss.getBrainMessage();
			if (targetDate.trim().equals("")) {
				targetDate = "";
				msg.setIntervallsDateError("Bitte geben Sie ein Datum ein.");
				return null;
			}
			Date newTargetDate = null;
			try {
				newTargetDate = SimpleDateFormat.getDateInstance().parse(targetDate);

			} catch (ParseException e) {
				e.printStackTrace();
				msg.setIntervallsDateError("Bitte geben Sie ein gültiges Datum ein.");
				return null;
			}
			long now = (new Date()).getTime();
			if (newTargetDate.getTime() < now) {
				msg.setIntervallsDateError("Das Datum muss mindestens morgen sein.");
				return null;
			}

			if (!newTargetDate.equals(realTargetDate)) {
				realTargetDate = newTargetDate;
				long diff = realTargetDate.getTime() - now;
				intervallUnit = diff / 364;
				calcBreakTimes();
				store();
				log.info("New target date: " + targetDate);
			} else
				log.info("Target date unchanged");
		}

		return ret;
	}

	private void store() {
		try {
			BrainSystem.getBrainSystem().getBrainDB().storeUserLesson(this);
			dirty = false;
		} catch (DBException e) {
			log.error("Error updating intervalls.", e);
		}
	}

	public String reset() {
		try {
			BrainSystem.getBrainSystem().getBrainDB().resetUserLesson(this);
		} catch (DBException e) {
			log.error("Failed to reset UserLesson.", e);
		}
		userStats.invalidate();
		return "user";
	}

	private void calcBreakTimes() {
		long tag = 1000 * 60 * 60 * 24;
		long min10 = 1000 * 60 * 10;
		breakTimes[1] = intervallUnit > tag ? min10 : 0;
		breakTimes[1] = intervallUnit * 1;
		breakTimes[2] = intervallUnit * 3;
		breakTimes[3] = intervallUnit * 9;
		breakTimes[4] = intervallUnit * 27;
		breakTimes[5] = intervallUnit * 81;
		breakTimes[6] = intervallUnit * 243;
		breakTimes[7] = breakTimes[6];
		breakTimes[8] = breakTimes[6];
		breakTimes[9] = breakTimes[6];
	}

	@XmlTransient
	public String getNextUserItemTimeDiff() throws DBException {
		System.out.println("gnt1");
		long now = System.currentTimeMillis();
		BrainSystem bs = BrainSystem.getBrainSystem();
		System.out.println("gnt2");
		long ms = bs.getBrainDB().getNextUserItemTimeDiff(id);
		System.out.println("gnt3");
		ms = ms - now;
		long sec = (ms < 1000 ? 1000 : ms) / 1000;
		long d = sec / 86400;
		sec = sec % 86400;
		long h = sec / 3600;
		sec = sec % 3600;
		long m = sec / 60;
		sec = sec % 60;

		System.out.println("TS: " + ms);

		BrainSession bss = null;
		try {
			bss = bs.getBrainSession();
		} catch (Exception e) {
			// von der JSP () aus gibt es keine Session
		}
		ResourceBundle rb = null;
		if (bss != null)
			rb = bss.getResourceBundle();
		else
			rb = ResourceBundle.getBundle("org.stoevesand.brain.i18n.MessagesBundle", new Locale("en", "EN"));

		System.out.println("bss: " + bss);
		System.out.println("rb: " + rb);

		String text = rb.getString("no_items_date");
		String ret = MessageFormat.format(text, d, h, m, sec);
		// String ret = "" + d + " Tag" + (d == 1 ? "" : "e") + ", " + h + ":" + m +
		// ":" + sec;

		System.out.println("ret: " + ret);

		return ret;
	}

	public String toXML() {
		StringBuilder buf = new StringBuilder();
		try {
			buf.append("<UserLesson id=\"" + getId() + "\">");
			buf.append("<description>");
			buf.append(getLesson().getDescription());
			buf.append("</description>");
			buf.append("<title>");
			buf.append(getLesson().getTitle());
			buf.append("</title>");
			buf.append("<available>");
			buf.append(getAvailable());
			buf.append("</available>");
			buf.append("</UserLesson>");
		} catch (Exception e) {
		}
		return buf.toString();
	}

	public String toJSON() {
		StringBuilder buf = new StringBuilder();
		try {
			buf.append("{ ");
			buf.append(" \"id\" : " + getId() + ", ");
			buf.append(" \"description\" : \"");
			buf.append(getLesson().getDescription());
			buf.append("\", ");
			buf.append(" \"title\" : \"");
			buf.append(getLesson().getTitle());
			buf.append("\", ");
			buf.append(" \"lesson\" : ");
			buf.append(getLesson().toJSON());
			buf.append(", ");
			buf.append(" \"type\" : ");
			buf.append(getLesson().getLessonType());
			buf.append(", ");
			buf.append(" \"showPinyin\" : ");
			buf.append(getConfig().getShowPinyin() ? true : false);
			buf.append(", ");
			buf.append(" \"available\" : ");
			buf.append(getAvailable());
			buf.append(" } ");

			// BrainSession.currentUserLesson.config.showPinyin

		} catch (Exception e) {
		}
		return buf.toString();
	}

}
