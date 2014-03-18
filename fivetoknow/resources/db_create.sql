DROP TABLE IF EXISTS `fivetoknow`.`answers`;
CREATE TABLE  `fivetoknow`.`answers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `itemID` int(10) unsigned NOT NULL default '0',
  `text` text NOT NULL,
  `visible` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fivetoknow`.`items`;
CREATE TABLE  `fivetoknow`.`items` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `text` text NOT NULL,
  `answer` int(10) unsigned default NULL,
  `lessonID` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fivetoknow`.`lessons`;
CREATE TABLE  `fivetoknow`.`lessons` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `keyboardLayout` varchar(4) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fivetoknow`.`stats`;
CREATE TABLE  `fivetoknow`.`stats` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userID` int(10) unsigned NOT NULL default '0',
  `logindate` datetime NOT NULL default '0000-00-00 00:00:00',
  `score` int(11) NOT NULL default '0',
  `score1` int(11) NOT NULL default '0',
  `score2` int(11) NOT NULL default '0',
  `score3` int(11) NOT NULL default '0',
  `score4` int(11) NOT NULL default '0',
  `score5` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fivetoknow`.`useritems`;
CREATE TABLE  `fivetoknow`.`useritems` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userlessonID` int(10) unsigned NOT NULL default '0',
  `itemID` int(10) unsigned NOT NULL default '0',
  `level` int(10) unsigned NOT NULL default '0',
  `last` datetime NOT NULL default '0000-00-00 00:00:00',
  `next` datetime NOT NULL default '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL default '0',
  `wright` int(10) unsigned NOT NULL default '0',
  `wrong` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fivetoknow`.`userlessons`;
CREATE TABLE  `fivetoknow`.`userlessons` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userID` int(10) unsigned NOT NULL default '0',
  `lessonID` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fivetoknow`.`users`;
CREATE TABLE  `fivetoknow`.`users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;