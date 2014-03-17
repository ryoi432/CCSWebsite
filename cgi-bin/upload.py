#!/usr/bin/python
# -*- coding: utf-8 -*-

import datetime
import locale 
import sqlite3
import cgi
import os
from data_module import *

def addTopics(Title,Body,Date = datetime.datetime.today().strftime("%Y-%m-%d")):
	con=sqlite3.connect('./dbfile.db')
	cur=con.cursor()
	try:
		cur.execute("""create table Topics(
						id INTEGER PRIMARY KEY,
						title text,
						date text,
						body text);"""
					)
	except:
		pass

	cur.execute(u"""insert into Topics (title, date, body)
							values  (?, ?, ?);""", (Title,Date,Body))
	con.commit()

	print "3"
	print "finish!"

	return




print "Content-type: text/html;charset=utf-8\n"
req = Request()
#パスは各自設定してください
if req.getreq("pass") == "pass":
	title = req.getreq("title")
	body = req.getreq("body")
	addTopics(title,body)
else:
	print "wrong password"

