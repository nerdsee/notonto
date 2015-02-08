package org.stoevesand.brain.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import org.jboss.logging.Logger;
import org.stoevesand.brain.BrainSystem;
import org.stoevesand.brain.exceptions.DBException;

@XmlRootElement(name = "userlesson")
public class SingleUserLesson extends UserLesson {

	private static Logger log = Logger.getLogger(SingleUserLesson.class);

	// public UserLesson(long id, long userId, long lessonId) {
	// this.id = id;
	// this.userId = userId;
	// this.lessonId=lessonId;
	// }

	SingleUserLesson() {
	}

	public SingleUserLesson(ResultSet rs) throws SQLException {
		super(rs);
	}

	@XmlTransient
	public String getIdList() {
		return "(" + id + ")";
	}

	@XmlTransient
	public UserItem getNextUserItem() throws DBException {
		log.debug("get next ui...");
		//FacesContext context = FacesContext.getCurrentInstance();

		// userStats.invalidate();

		currentUserItem = BrainSystem.getBrainSystem().getBrainDB().getNextUserItem(this);
		//if (context != null)
			// BrainSystem.storeBeanFromFacesContext("CurrentUserItem",context,
			// currentUserItem);
			BrainSystem.getBrainSystem().getBrainSession().setCurrentUserItem(currentUserItem);
		return currentUserItem;
	}

	@XmlTransient
	public Date getNextUserItemTime() throws DBException {
		Date ret = BrainSystem.getBrainSystem().getBrainDB().getNextUserItemTime(id);
		return ret;
	}

	@XmlTransient
	public int getMaxItemsLevel0() {
		int ret = 0;

		try {
			ret = getLesson().getMaxItemsLevel0();
		} catch (DBException e) {
		}

		return ret;
	}

	public long getBreakTime(int i) {
		long breakTime = 0;
		if (intervallType != 0) {
			breakTime = breakTimes[i];
		} else {
			BrainSystem bs = BrainSystem.getBrainSystem();
			breakTime = bs.getBreakTime(i);
		}
		return breakTime;
	}

}
