package org.stoevesand.brain.model;

import java.sql.ResultSet;
import java.util.Date;
import java.util.Vector;

import javax.faces.context.FacesContext;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.log4j.Logger;
import org.stoevesand.brain.BrainSystem;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.util.DBUtil;

@XmlRootElement(name = "userlesson")
public class CombinedUserLesson extends UserLesson implements IUserLesson {

	private static Logger log = Logger.getLogger(CombinedUserLesson.class);

	Vector<IUserLesson> userLessons = new Vector<IUserLesson>();

	CombinedUserLesson() {
	}

	public CombinedUserLesson(ResultSet rs) throws DBException {
		super();

		this.id = DBUtil.getLong(rs, "ulid");
		this.lessonId = DBUtil.getLong(rs, "lessonID");
		this.userId = DBUtil.getLong(rs, "userID");
		userLessons = BrainSystem.getBrainSystem().getBrainDB().getUserLessons(this);
	}

	public String getIdList() {
		return "()";
	}

	// TODO: Anpassen
	public Lesson getLesson() throws DBException {
		return BrainSystem.getBrainSystem().getBrainDB().getLesson(lessonId);
	}

	// TODO: Anpassen
	public UserItem getNextUserItem() throws DBException {
		log.debug("get next ui...");
		FacesContext context = FacesContext.getCurrentInstance();

		// userStats.invalidate();

		currentUserItem = BrainSystem.getBrainSystem().getBrainDB().getNextUserItem(this);
		if (context != null)
			// BrainSystem.storeBeanFromFacesContext("CurrentUserItem",context,
			// currentUserItem);
			BrainSystem.getBrainSystem().getBrainSession().setCurrentUserItem(currentUserItem);
		return currentUserItem;
	}

	// TODO: Anpassen
	public Date getNextUserItemTime() throws DBException {
		log.debug("get next time...");
		Date ret = BrainSystem.getBrainSystem().getBrainDB().getNextUserItemTime(id);
		return ret;
	}

	public int getMaxItemsLevel0() {
		// TODO Auto-generated method stub
		return 0;
	}

	public long getBreakTime(int i) {
		BrainSystem bs = BrainSystem.getBrainSystem();
		long breakTime = bs.getBreakTime(i);
		return breakTime;
	}

}
