#!/usr/bin/python
# -*- coding: utf-8 -*-

import datetime
import locale 
import sqlite3
import cgi
import os
import traceback
import sys

class Request(object):
	def __init__(self, environ=os.environ):
		self.form__=cgi.FieldStorage()
		self.environ__=environ

	def getreq(self,key):
		if self.form__.has_key(key) == False :
			raise KeyError
		return self.form__[key].value
		

class TopicsData(object):
	def __init__(self, Title, Body, Date = datetime.datetime.today() ):
		#Parameter sequence is't elegant...
		self.__title = Title
		self.__body = Body
		self.__date = Date
		return

	def encodeJson(self):
		"""TopicsData encode to Json Data"""
		Param = {"title":self.__title, "date":self.__date.strftime("%Y-%m-%d"), "body":self.__body}
		try:
			return_data=u"{'title':'%(title)s', 'date':'%(date)s', 'body':'%(body)s'}" % Param
		except:
			print "exc_info: %s" % str(sys.exc_info())
			print "[0]: %s" % sys.exc_info()[0]
			print "[1]: %s" % sys.exc_info()[1]
			traceback.print_tb(sys.exc_info()[2])
		return return_data.encode('utf_8')



