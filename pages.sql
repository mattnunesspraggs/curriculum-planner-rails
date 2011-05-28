-- phpMyAdmin SQL Dump
-- version 3.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 28, 2011 at 02:48 PM
-- Server version: 5.1.49
-- PHP Version: 5.3.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cp_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `tags` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `user_id`, `slug`, `content`, `tags`, `created_at`, `updated_at`) VALUES
(1, 'About', 2, 'about', '<p>First, a disclaimer: <strong>this website is not maintained with Bennington College. No actions you take on this website will be reflected in your official schedule. Adding a course to your [plan]-i-fication does not indicate your enrollment in the course nor does it indicate free spots in the course. Use this tool at your discretion to roughly plan out your schedule, but this site does not in any way replace the registration or course lottery procedures (even if that one kid down the hall tells you it does, because believe me, it doesn''t)</strong>.</p>\r\n\r\n<p>That being said, I made this site to <em>make registration easier</em>. For a "liberal, progressive" college, Bennington is technologically behind in the times (to put it lightly). The <a href="http://twitter.com/benningtondeans">Dean''s Office</a> assures me that we will shortly have some sort of online tools that integrate more tightly with the course registration databases. Until then, we''re stuck with paper and PDF copies of the curriculum. That''s where this site comes in.</p>\r\n\r\n<p>I can''t guarantee that Bennington will ever get rid of paper registration or PDF curriculi; but in this, I see a problem. PDFs are notoriously hard to search, and you can''t Ctrl-F (Cmd-F for Mac users) a paper copy of the curriculm. And, even if you''ve worked out a <a href="http://en.wikipedia.org/wiki/Search_algorithm" target="_blank">system for finding what you like</a>, you''re stuck with block paper and colored pencils to try and fit your courses into a schedule that works. As a computer science student and an <a href="http://en.wikipedia.org/wiki/INTJ" target="_blank">INTJ</a>, I constantly ask "is ths efficient?" and "does it work?". And frankly, neither is really true.</p>\r\n\r\n<p>In 2009, I was involved in a project to work on a similar project. It started off as a programming language proof-of-concept project, and evolved quickly to be too large and complex of a project for the framework we were using (namely, no framework at all, which is a problem). Then, in 2010, I decided to use this bloated project as a (ideological) starting point to learn <a href="http://www.rubyonrails.org/" target="_blank">Ruby on Rails</a>, a web application framework. And that''s kind of it.</p>\r\n\r\n<p>I hope that you find this site useful.</p>', 'about', '2011-03-16 23:20:55', '2011-05-26 04:18:05'),
(2, '404 - File or Resource Not Found', 2, 'error404', '<h2>Looking for something?</h2>\r\n        <br /><br />\r\n        <h3>There are lots of reasons why you may not be able to find what you''re looking for:</h3>\r\n        <br />\r\n        <ul>\r\n        <li>- You''ve run into a broken link. My bad.</li>\r\n        <li>- There''s a server issue. I''ll kick it, try again later.</li>\r\n        <li>- You tried to be a smartass and type in a URL yourself. Stop that.</li>\r\n        </ul>', '', '2011-03-17 00:05:19', '2011-05-26 04:19:53'),
(3, 'Importing an ICS File', 2, 'import-ics-file', '<img style="float: right;" src="/images/calendar_import.png" />\r\n                                        <p>So you''ve set your schedule, gotten all your signatures and made out like a bandit in the 2000-level course lottery. What next?</p>\r\n                                        <p>Well, personally, I''d recommend that you set your schedule up in <a href="/">[plan]-i-fication</a>, <a href="/schedule.ics">download it</a>, and then upload it into your calendar software!</p>\r\n                                        <p>[plan]-i-fication allows you to download your calendar in <a href="http://en.wikipedia.org/wiki/ICalendar">ICalendar</a> format. No, not ICal format - that''s a Mac desktop application. ICalendar is a standard (<a href="http://tools.ietf.org/html/rfc5545">RFC 5545</a>, to be specific) computer-based representation of calendar events, and <a href="http://en.wikipedia.org/wiki/List_of_applications_with_iCalendar_support">any calendar software worth its salt</a> can import and export in this format. But, since all Bennington students have a <a href="http://sso.bennington.edu">Google Apps for Education account</a>, we will concentrate on how to import an .ICS file into Google Calendar. You can, however, <a href="http://www.google.com">easily find instructions for your favorite Calendar application.</a></p>\r\n                                        <ol>\r\n                                        	<li>Log in to <a href="http://sso.bennington.edu">teh interwebs</a>.</li>\r\n                                        	<li>Click on the "Calendar" link at the top of the window.</li>\r\n                                        	<li>In the left column, under "Other Calendars", click "Add" and select "Import Calendar" from the popup menu.</li>\r\n                                        	<li>Choose the file location, the calendar into which you would like to upload your class schedule, and click "Import".</li>\r\n                                        	<li>You are now <strong>le done</strong>. Feel free to set alarms and peruse your newly uploaded schedule!</li>\r\n                                        </ol>\r\n                <img style="display: block; margin: 10px auto;" src="/images/import.png" />', 'import,ics,ical', '2011-05-13 02:02:09', '2011-05-26 02:50:30'),
(4, 'How to Add and Remove Courses', 2, 'help-adding-courses', '<p>Adding courses is pretty easy, and there are a couple of ways about it. There are three methods:</p>\r\n<h2>The Curriculum Method</h2>\r\n<ol>\r\n	<li>Go to the <a href="/courses" target="_blank">Course Listing</a>. It is sorted by subjec- I mean, Bennington doesn''t have subjects, so it''s sorted... oh, I don''t know, maybe it''s sorted randomly or something (Protip: It''s sorted by subject, just don''t tell anyone).</li>\r\n	<li>You can click any one of the subjects and view the courses in that subject. To return to the list of subjects, click on the subject name again.</li>\r\n	<li>When you find a class, you can click "Add Course to Schedule". Surprisingly enough, you can also click "Remove Course from Schedule" to remove the course from your schedule.</li>\r\n</ol>\r\n<h2>The Search Method</h2>\r\n<ol>\r\n	<li>Go to the <a href="/courses/search" target="_blank">Search page</a>. You can type any search term, and it will be run against all courses (for reference, it searches the <strong>course title</strong>, <strong>course code</strong>, <strong>instructor name</strong>, and <strong>course description</strong> fields).\r\n	<li>See <strong>Step 3</strong> above.</li>\r\n</ol>\r\n<h2>The Random Method</h2>\r\n<ol>\r\n	<li>Go to the <a href="/courses/random" target="_blank">Random course page</a>.</li>\r\n	<li>Now, follow this simple guide: Do you like this course?\r\n		<ul><li><strong>YES</strong>: See <strong>Step 2</strong> above.</li>\r\n			<li><strong>NO</strong>: Do NOT see <strong>Step 2</strong> above.</li>\r\n		</ul>\r\n	<li>Repeat!</li>\r\n</ol>\r\n<p>At any point, you can switch over to the <a href="/schedule" target="_blank">Schedule view</a> to see how your schedule is shaping up, or you can jump to <a href="/home">your profile</a> to see your courses and credits! Have fun adding courses!</p>', 'adding,courses,help', '2011-05-26 03:53:02', '2011-05-26 03:57:47');
