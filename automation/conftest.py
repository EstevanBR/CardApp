import base64
import logging
import socket
from datetime import datetime

import pytest
from appium import webdriver
from appium.webdriver.webdriver import WebDriver


@pytest.fixture(scope="session", autouse=True)
def desired_capabilities() -> dict:
    desired_capabilities = {
        "bundleId": "com.toiletsnakes.Card",
        "deviceName": "iPhone 8",
        "udid": "1BDA0BD6-A0F6-4C4F-AF7D-94F3EDDDE29A",
        "platformVersion": "13.0",
        "platformName": "iOS",
        "noReset": True,
        "newCommandTimeout": 10,
        "autoLaunch": False,
        "isHeadless": False,
        "usePrebuiltWDA": True,
        "processArguments": {
            "args": [
                "RESET"
            ], "env": {

            }
        }
    }
    logging.debug(f"desired_capabilities\n{desired_capabilities}")
    return desired_capabilities


@pytest.fixture(scope="session", autouse=True)
def driver(desired_capabilities: dict) -> WebDriver:
    hostname = socket.gethostname()
    ip = socket.gethostbyname(hostname)

    EXECUTOR = f"http://{ip}:4723/wd/hub"

    driver = webdriver.Remote(
        command_executor=EXECUTOR,
        desired_capabilities=desired_capabilities,
        direct_connection=True)
    logging.debug(
        f"created driver with desired_capabilities\n{desired_capabilities}")

    return driver


@pytest.fixture(scope="session", autouse=True)
def driver_setup(driver):
    logging.debug(f"starting driver session")
    driver.start_session(driver.desired_capabilities)


@pytest.fixture(scope="session", autouse=True)
def driver_teardown(driver):
    yield None
    logging.debug(f"ending driver session")
    driver.quit()


@pytest.fixture(scope="session", autouse=True)
def page(driver: WebDriver) -> None:
    from page.page import Page as Page
    logging.debug(f"providing Page class with driver")
    Page.driver = driver


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
