package org.stoevesand.brain.model;

import java.util.Date;

import org.stoevesand.brain.UserLessonConfig;
import org.stoevesand.brain.UserStats;
import org.stoevesand.brain.auth.User;
import org.stoevesand.brain.exceptions.DBException;

public interface IUserLesson {

	public long getId();

	public Lesson getLesson() throws DBException;

	public User getUser() throws DBException;

	public UserItem getNextUserItem() throws DBException;

	public String getNextUserItemTimeDiff() throws DBException;

	public Date getNextUserItemTime() throws DBException;

	public void deactivateCurrentItem() throws DBException;

	public UserLessonConfig getConfig();

	public int getAvailable() throws DBException;

	public int getLevel0() throws DBException;

	public int getLevel1() throws DBException;

	public int getLevel2() throws DBException;

	public int getLevel3() throws DBException;

	public int getLevel4() throws DBException;

	public int getScore() throws DBException;

	public void activateUserItem() throws DBException;

	public UserItem getCurrentUserItem();

	public String getIdList();
	
	public UserStats getUserStats();

	public int getMaxItemsLevel0();

	public String toXML();

	public String toJSON();

	public long getBreakTime(int i);
}
