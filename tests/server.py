import signal
import subprocess
import logging

from robot.libraries.BuiltIn import BuiltIn
from django.contrib.staticfiles.testing import StaticLiveServerTestCase
from django.core.management import call_command

from talks.events.tests import patch_requests

class Server(object):
    def __init__(self):
        self._tc = StaticLiveServerTestCase('__init__')

    def start_server(self):
        self._requests_patcher = patch_requests()
        self._tc.setUpClass()
        logging.info("Server started: %s", self._tc.live_server_url)
        BuiltIn().set_suite_variable('${HOST}', self._tc.live_server_url)

    def stop_server(self):
        self._tc.tearDownClass()
        self._requests_patcher.stop()

    def server_command(self, name, *args, **kwargs):
        call_command(name, *args, **kwargs)

server = Server
