package org.stoevesand.brain;

import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.brain.model.IUserLesson;

public class UserStats {

	boolean dirty = true;

	IUserLesson parentUserLesson = null;

	int[] levelList = new int[6];
	int available = 0;
	int score = 0;

	public int getScore() throws DBException {
		check();
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public int getAvailable() throws DBException {
		check();
		return available;
	}

	public void setAvailable(int available) {
		this.available = available;
	}

	public UserStats(IUserLesson parentUserLesson) {
		this.parentUserLesson = parentUserLesson;
	}

	public int[] getLevelList() {
		return levelList;
	}

	public void invalidate() {
		dirty = true;
	}

	void check() throws DBException {
		if (dirty)
			load();
	}

	void load() throws DBException {
		reset();
		BrainSystem.getBrainSystem().getBrainDB().getUserLessonLevels(parentUserLesson);
		dirty = false;
	}
	
	void reset() {
		levelList[0]=0;
		levelList[1]=0;
		levelList[2]=0;
		levelList[3]=0;
		levelList[4]=0;
		levelList[5]=0;
	}

	public int getLevel0(IUserLesson userLesson) throws DBException {
		check();
		return levelList[0];
	}

	public int getLevel1(IUserLesson userLesson) throws DBException {
		check();
		return levelList[1];
	}

	public int getLevel2(IUserLesson userLesson) throws DBException {
		check();
		return levelList[2];
	}

	public int getLevel3(IUserLesson userLesson) throws DBException {
		check();
		return levelList[3];
	}

	public int getLevel4(IUserLesson userLesson) throws DBException {
		check();
		return levelList[4];
	}

	public int getLevel5(IUserLesson userLesson) throws DBException {
		check();
		return levelList[5];
	}

//	public void forgotten(int level) {
//		if (level > 5)
//			level = 5;
//		levelList[level]--;
//		levelList[0]++;
//	}
//
//	public void learned(int level) {
//		levelList[level]--;
//		levelList[level + 1]++;
//	}
//
//	public void activateItem() {
//		levelList[0]++;
//	}
//
//	public void force(int level) {
//		levelList[level]++;
//		levelList[0]--;
//	}

}
