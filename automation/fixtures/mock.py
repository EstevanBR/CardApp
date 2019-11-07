import pytest
import logging
import time
from unittest.mock import MagicMock
from page.page import Page
from report.report import Report
from appium.webdriver.webdriver import WebDriver


def pytest_addoption(parser):
    parser.addoption("--mock", dest="mock", action="store_true")


@pytest.fixture(scope="session", autouse=True)
def mock(pytestconfig) -> None:
    if pytestconfig.option.mock is False:
        return
    logging.debug(f"Mocking web driver")
    Page.__init__ = MagicMock(return_value=None)
    Page.inject_driver = MagicMock()
    Page.__driver = MagicMock()
    Page._Page__driver = MagicMock()
    Page._element = MagicMock()
    Page._element.click = MagicMock()
    Page.find_element = MagicMock()

    Report.passed = MagicMock(return_value=True)
    Report.finalize = MagicMock()
    Report.soft_assert = MagicMock()

    time.sleep = MagicMock(return_value=None)

    WebDriver.implicitly_wait = MagicMock()
    WebDriver.start_session = MagicMock()
    WebDriver.terminate_app = MagicMock()
    WebDriver.activate_app = MagicMock()
    WebDriver.launch_app = MagicMock()
    WebDriver.desired_capabilities = MagicMock(return_value={"bundleId": ""})
    WebDriver.execute_script = MagicMock()
    WebDriver.start_recording_screen = MagicMock(return_value="")
    WebDriver.stop_recording_screen = MagicMock(return_value="")
    WebDriver.quit = MagicMock()
