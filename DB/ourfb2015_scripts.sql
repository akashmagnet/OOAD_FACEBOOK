SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `ourfacebook2015` ;
CREATE SCHEMA IF NOT EXISTS `ourfacebook2015` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ourfacebook2015` ;

-- -----------------------------------------------------
-- Table `ourfacebook2015`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`user` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`user` (
  `userid` INT NOT NULL AUTO_INCREMENT,
  `uemail` VARCHAR(45) NOT NULL,
  `upwd` VARCHAR(45) NOT NULL,
  `ufirstname` VARCHAR(45) NOT NULL,
  `ulastname` VARCHAR(45) NULL,
  `udob` DATE NOT NULL,
  `ugender` ENUM('M','F','O') NOT NULL,
  `uphone` VARCHAR(45) NULL,
  `usecques` VARCHAR(100) NOT NULL,
  `usecans` VARCHAR(50) NOT NULL,
  `ucreationtime` DATETIME NOT NULL,
  `ulastloggedon` DATETIME NOT NULL,
  `uotp` BIGINT NOT NULL,
  `ustatus` ENUM('Active','Inactive','Pending','Rejected') NOT NULL,
  `uprofilepic` LONGBLOB NULL,
  `ucoverpic` LONGBLOB NULL,
  PRIMARY KEY (`userid`),
  UNIQUE INDEX `uemail_UNIQUE` (`uemail` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`profile` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`profile` (
  `userid` INT NOT NULL,
  `currentplace` VARCHAR(45) NULL,
  `language` VARCHAR(45) NULL,
  `homeplace` VARCHAR(45) NULL,
  `aboutme` MEDIUMTEXT NULL,
  `profilestatus` VARCHAR(45) NULL,
  `martialstatus` ENUM('Single','Married','Engaged','Divorced','Breakup') NULL,
  INDEX `fk_profile_user_idx` (`userid` ASC),
  CONSTRAINT `fk_profile_user`
    FOREIGN KEY (`userid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`organization` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`organization` (
  `userid` INT NOT NULL,
  `organizationname` VARCHAR(45) NULL,
  `workingfrom` DATE NULL,
  `workingto` DATE NULL,
  `designation` VARCHAR(45) NULL,
  INDEX `fk_organization_1_idx` (`userid` ASC),
  CONSTRAINT `fk_organization_1`
    FOREIGN KEY (`userid`)
    REFERENCES `ourfacebook2015`.`profile` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`institute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`institute` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`institute` (
  `userid` INT NOT NULL,
  `studiedfrom` DATE NULL,
  `institutename` VARCHAR(45) NULL,
  `studiedto` DATE NULL,
  `degree` VARCHAR(45) NULL,
  INDEX `fk_institute_1_idx` (`userid` ASC),
  CONSTRAINT `fk_institute_1`
    FOREIGN KEY (`userid`)
    REFERENCES `ourfacebook2015`.`profile` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`events` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`events` (
  `eventid` INT NOT NULL AUTO_INCREMENT,
  `eventtitle` VARCHAR(45) NOT NULL,
  `eventdescription` VARCHAR(45) NULL,
  `eventtime` TIMESTAMP NOT NULL,
  `eventplace` VARCHAR(45) NOT NULL,
  `createdby` INT NOT NULL,
  `isactive` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`eventid`),
  INDEX `fk_events_1_idx` (`createdby` ASC),
  CONSTRAINT `fk_events_1`
    FOREIGN KEY (`createdby`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`event_invitees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`event_invitees` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`event_invitees` (
  `invitationid` INT NOT NULL AUTO_INCREMENT,
  `eventid` INT NOT NULL,
  `inviteeid` INT NOT NULL,
  `confirmation` ENUM('Join','Maybe','Decline') NOT NULL DEFAULT 'Decline',
  `invitationtimestamp` TIMESTAMP NOT NULL,
  `notify` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`invitationid`),
  INDEX `fk_invitees_1_idx` (`eventid` ASC),
  INDEX `fk_invitees_2_idx` (`inviteeid` ASC),
  CONSTRAINT `fk_invitees_1`
    FOREIGN KEY (`eventid`)
    REFERENCES `ourfacebook2015`.`events` (`eventid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invitees_2`
    FOREIGN KEY (`inviteeid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`groups` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`groups` (
  `groupid` INT NOT NULL AUTO_INCREMENT,
  `groupname` VARCHAR(45) NOT NULL,
  `groupcreationtime` TIMESTAMP NOT NULL,
  `createdby` INT NOT NULL,
  `groupdescription` VARCHAR(45) NULL,
  `isactive` TINYINT(1) NULL DEFAULT 1,
  `groupphoto` LONGBLOB NULL,
  PRIMARY KEY (`groupid`),
  UNIQUE INDEX `groupname_UNIQUE` (`groupname` ASC),
  INDEX `fk_groups_1_idx` (`createdby` ASC),
  CONSTRAINT `fk_groups_1`
    FOREIGN KEY (`createdby`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`group_members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`group_members` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`group_members` (
  `gmid` INT NOT NULL AUTO_INCREMENT,
  `groupid` INT NOT NULL,
  `groupuserid` INT NOT NULL,
  `timestamp` TIMESTAMP NULL,
  `confirmation` ENUM('Active','Inactive') NULL,
  `isactive` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`gmid`),
  INDEX `fk_group_members_1_idx` (`groupid` ASC),
  INDEX `fk_group_members_2_idx` (`groupuserid` ASC),
  CONSTRAINT `fk_group_members_1`
    FOREIGN KEY (`groupid`)
    REFERENCES `ourfacebook2015`.`groups` (`groupid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_members_2`
    FOREIGN KEY (`groupuserid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`friends`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`friends` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`friends` (
  `friendid` INT NOT NULL AUTO_INCREMENT,
  `friend_sender` INT NOT NULL,
  `friend_receiver` INT NOT NULL,
  `friendshipstatus` ENUM('Accepted','Pending','Rejected','Blocked') NOT NULL DEFAULT 'Pending',
  `notify` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`friendid`, `friend_sender`, `friend_receiver`),
  INDEX `fk_user_has_user_user2_idx` (`friend_receiver` ASC),
  INDEX `fk_user_has_user_user1_idx` (`friend_sender` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`friend_sender`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`friend_receiver`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`messages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`messages` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`messages` (
  `messageid` INT NOT NULL AUTO_INCREMENT,
  `senderid` INT NOT NULL,
  `receiverid` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `messagedetails` MEDIUMTEXT NOT NULL,
  `senderisactive` TINYINT(1) NOT NULL DEFAULT 1,
  `receiverisactive` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`messageid`),
  INDEX `fk_messages_1_idx` (`senderid` ASC),
  INDEX `fk_messages_2_idx` (`receiverid` ASC),
  CONSTRAINT `fk_messages_1`
    FOREIGN KEY (`senderid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_2`
    FOREIGN KEY (`receiverid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`message_notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`message_notifications` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`message_notifications` (
  `msgnotid` INT NOT NULL AUTO_INCREMENT,
  `messageid` INT NOT NULL,
  `touser` INT NOT NULL,
  `msgdesc` VARCHAR(45) NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `isactive` TINYINT(1) NOT NULL DEFAULT 1,
  `count` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`msgnotid`),
  INDEX `fk_message_notifications_1_idx` (`messageid` ASC),
  INDEX `fk_message_notifications_2_idx` (`touser` ASC),
  CONSTRAINT `fk_message_notifications_1`
    FOREIGN KEY (`messageid`)
    REFERENCES `ourfacebook2015`.`messages` (`messageid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_notifications_2`
    FOREIGN KEY (`touser`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`posts` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`posts` (
  `postid` INT NOT NULL AUTO_INCREMENT,
  `postdetails` LONGTEXT NULL,
  `postimage` LONGBLOB NULL,
  `postcreatedby` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `posttype` ENUM('Normal','Group','Friend') NOT NULL DEFAULT 'Normal',
  `likecount` INT NOT NULL DEFAULT 0,
  `commentcount` INT NOT NULL DEFAULT 0,
  `groupid` INT NULL,
  `friendid` INT NULL,
  PRIMARY KEY (`postid`),
  INDEX `fk_posts_2_idx` (`groupid` ASC),
  INDEX `fk_posts_1_idx` (`postcreatedby` ASC),
  INDEX `fk_posts_3_idx` (`friendid` ASC),
  CONSTRAINT `fk_posts_1`
    FOREIGN KEY (`postcreatedby`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_2`
    FOREIGN KEY (`groupid`)
    REFERENCES `ourfacebook2015`.`groups` (`groupid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_3`
    FOREIGN KEY (`friendid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`post_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`post_like` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`post_like` (
  `likeid` INT NOT NULL AUTO_INCREMENT,
  `postid` INT NOT NULL,
  `userlikedid` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (`likeid`),
  INDEX `fk_post_like_1_idx` (`postid` ASC),
  INDEX `fk_post_like_2_idx` (`userlikedid` ASC),
  CONSTRAINT `fk_post_like_1`
    FOREIGN KEY (`postid`)
    REFERENCES `ourfacebook2015`.`posts` (`postid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_like_2`
    FOREIGN KEY (`userlikedid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`post_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`post_comment` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`post_comment` (
  `commentid` INT NOT NULL,
  `postid` INT NOT NULL,
  `comment` MEDIUMTEXT NULL,
  `timestamp` TIMESTAMP NULL,
  `usercommentedid` INT NOT NULL,
  `post_commentcol` VARCHAR(45) NULL,
  PRIMARY KEY (`commentid`),
  INDEX `fk_post_comment_1_idx` (`postid` ASC),
  INDEX `fk_post_comment_2_idx` (`usercommentedid` ASC),
  CONSTRAINT `fk_post_comment_1`
    FOREIGN KEY (`postid`)
    REFERENCES `ourfacebook2015`.`posts` (`postid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_comment_2`
    FOREIGN KEY (`usercommentedid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`comment_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`comment_like` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`comment_like` (
  `clid` INT NOT NULL AUTO_INCREMENT,
  `commentid` INT NOT NULL,
  `cluserid` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (`clid`),
  INDEX `fk_comment_like_1_idx` (`commentid` ASC),
  INDEX `fk_comment_like_2_idx` (`cluserid` ASC),
  CONSTRAINT `fk_comment_like_1`
    FOREIGN KEY (`commentid`)
    REFERENCES `ourfacebook2015`.`post_comment` (`commentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_like_2`
    FOREIGN KEY (`cluserid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ourfacebook2015`.`post_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ourfacebook2015`.`post_notification` ;

CREATE TABLE IF NOT EXISTS `ourfacebook2015`.`post_notification` (
  `pnid` INT NOT NULL AUTO_INCREMENT,
  `postid` INT NOT NULL,
  `fromuserid` INT NOT NULL,
  `pndescription` TEXT NULL,
  `isactive` TINYINT(1) NOT NULL DEFAULT 1,
  `timestamp` TIMESTAMP NOT NULL,
  `isother` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`pnid`),
  INDEX `fk_post_notification_1_idx` (`postid` ASC),
  INDEX `fk_post_notification_2_idx` (`fromuserid` ASC),
  CONSTRAINT `fk_post_notification_1`
    FOREIGN KEY (`postid`)
    REFERENCES `ourfacebook2015`.`posts` (`postid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_notification_2`
    FOREIGN KEY (`fromuserid`)
    REFERENCES `ourfacebook2015`.`user` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
