#!/usr/bin/python
from wsgiref.handlers import CGIHandler
from totrello import app

CGIHandler().run(app)
