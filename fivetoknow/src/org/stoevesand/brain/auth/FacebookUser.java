package org.stoevesand.brain.auth;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.stoevesand.util.DBUtil;

public class FacebookUser extends User {
	public FacebookUser(ResultSet rs) throws SQLException {
		super(rs);
		this.uid=DBUtil.getLong(rs, "facebookID");
	}

	public FacebookUser(long uid) {
		this.uid = uid;
		setPassword("===GEN===ualuhslurhluerl4cvbnsdf978g===");
		this.id = -1;
		this.registerDate = new Date();
		this.type = USER_TYPE_USER;
		this.unlocked = true;
		dirty = true;
	}

	String name;
	private long uid;

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setFacebookId(long uid) {
		this.uid = uid;
	}

	public long getFacebookId() {
		return uid;
	}

	public void setFacebookIdString(String s_fbid) {
		try {
			this.uid = Long.parseLong(s_fbid);
		} catch (NumberFormatException nfe) {
			this.uid = -1;
		}
	}

	public String getFacebookIdString() {
		return uid == 0 ? "" : "" + uid;
	}
}
