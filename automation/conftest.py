import base64
import logging
import socket
from datetime import datetime
from test_report.test_report import TestReport
# from unittest.mock import MagicMock

import pytest
from appium import webdriver
from appium.webdriver.webdriver import WebDriver

"""
Default desired_capabilities fixtures
"""
@pytest.fixture(scope="session", autouse=True)
def bundleId() -> str:
    return "com.toiletsnakes.Card"


@pytest.fixture(scope="session", autouse=True)
def app() -> str:
    return "/Users/ehernandez/Desktop/Build/Products/Debug-iphonesimulator/Card.app/"


@pytest.fixture(scope="session", autouse=True)
def deviceName() -> str:
    return "iPhone 8"


@pytest.fixture(scope="session", autouse=True)
def udid() -> str:
    return "1BDA0BD6-A0F6-4C4F-AF7D-94F3EDDDE29A"


@pytest.fixture(scope="session", autouse=True)
def platformVersion() -> str:
    return "13.0"


@pytest.fixture(scope="session", autouse=True)
def platformName() -> str:
    return "iOS"


@pytest.fixture(scope="session", autouse=True)
def derivedDataPath() -> str:
    return "/Users/ehernandez/Library/Developer/Xcode/DerivedData/WebDriverAgent-ciegwgvxzxdrqthilmrmczmqvrgu"


@pytest.fixture(scope="session", autouse=True)
def noReset() -> bool:
    return True


@pytest.fixture(scope="session", autouse=True)
def fullReset() -> bool:
    return False


@pytest.fixture(scope="session", autouse=True)
def desired_capabilities(
    bundleId: str,
    app: str,
    deviceName: str,
    udid: str,
    platformVersion: str,
    platformName: str,
    noReset: bool,
    fullReset: bool,
    derivedDataPath: str
) -> dict:
    desired_capabilities = {
        "bundleId": bundleId,
        "app": app,
        "deviceName": deviceName,
        "udid": udid,
        "platformVersion": platformVersion,
        "platformName": platformName,
        "noReset": noReset,
        "fullReset": fullReset,
        "newCommandTimeout": 60,
        "autoLaunch": False,
        "autoAcceptAlerts": True,
        # "webDriverAgentUrl": "http://localhost:8100",
        # "usePrebuiltWDA": False,
        "derivedDataPath": derivedDataPath,
        "processArguments": {
            "args": [
                "RESET"
            ],
            "env": {

            }
        }
    }
    logging.debug(f"desired_capabilities\n{desired_capabilities}")
    return desired_capabilities


"""
driver fixture
"""


@pytest.fixture(scope="session", autouse=True)
def driver(desired_capabilities: dict) -> WebDriver:
    hostname = socket.gethostname()
    ip = socket.gethostbyname(hostname)

    driver = webdriver.Remote(
        command_executor=f"http://{ip}:4723/wd/hub",
        desired_capabilities=desired_capabilities
    )
    driver.implicitly_wait(4)
    logging.debug(
        f"created driver with desired_capabilities\n{desired_capabilities}")

    return driver


@pytest.fixture(scope="session", autouse=True)
def page(driver: WebDriver) -> None:
    from page.page import Page as Page
    logging.debug(f"providing Page class with driver")
    Page.inject_driver(driver)


@pytest.fixture(scope="session", autouse=True)
def driver_setup(driver):
    logging.debug(f"starting driver session")

    driver.terminate_app(driver.desired_capabilities["bundleId"])
    driver.execute_script("mobile: launchApp", {"bundleId": driver.desired_capabilities["bundleId"], "arguments": driver.desired_capabilities["processArguments"]["args"]})
    driver.execute_script("mobile: activateApp", {"bundleId": driver.desired_capabilities["bundleId"]})


@pytest.fixture(scope="session", autouse=True)
def driver_teardown(driver):
    yield None
    logging.debug(f"ending driver session")
    driver.quit()


@pytest.fixture(scope="function", autouse=True)
def video(driver: WebDriver, request):
    logging.debug(f"started recording video")
    driver.start_recording_screen(videoType="mpeg4", bugReport=True)
    yield

    now = datetime.now()
    date_string = now.strftime("%Y-%m-%d_%H:%M:%S")

    video_name: str = f"{request.node.name}_{date_string}"
    file_name: str = f"videos/{video_name}.mp4"
    with open(file_name, "wb") as f:
        video: str = driver.stop_recording_screen()
        f.write(base64.b64decode(video))
        logging.debug(f"saved video to file: {file_name}")


@pytest.fixture(scope="function", autouse=True)
def test_report() -> TestReport:
    return TestReport()


@pytest.fixture(scope="function", autouse=True)
def report_tests(test_report: TestReport) -> None:
    yield None
    test_report.finalize()
    assert test_report.passed() is True
