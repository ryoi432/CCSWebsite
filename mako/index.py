#!/usr/bin/python
# -*- coding: UTF-8 -*-

# enable debugging
import cgitb
cgitb.enable()

import sys
from mako.lookup import TemplateLookup
from mako import exceptions

#print "Content-Type: text/plain;charset=utf-8"
#print

templatedir = "./template" # テンプレートファイルのディレクトリを指定
templatename = "test.template" # テンプレートファイル名

tl = TemplateLookup(directories=templatedir, output_encoding='utf-8', input_encoding='utf-8', encoding_errors='replace')

try:
	t = tl.get_template(templatename)
except exceptions.TopLevelLookupException, tlle:
	print >>sys.stderr ,'We could not find the template directory. - %s/%s'% (templatedir, templatename)
	raise
view = {}

view = {"title" : u"aaaa", "body": u"aaaa", "name" : u"テスト"} # テンプレートへ渡す値を設定しています。辞書が便利だと思います。
print t.render(**view) # key=value形式でMakoに渡すためにviewの前に**を記述しています。
