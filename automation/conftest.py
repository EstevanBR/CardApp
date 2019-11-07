import pytest

from fixtures.desired_capabilities import (app, bundleId, derivedDataPath,
                                           desired_capabilities, deviceName,
                                           fullReset, noReset, platformName,
                                           platformVersion, udid)
from fixtures.driver import driver
from fixtures.mock import mock
from fixtures.page import page
from fixtures.report import report
from fixtures.video import video

def pytest_addoption(parser):
    parser.addoption("--mock", dest="mock", action="store_true")
