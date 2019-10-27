# from __future__ import annotations
import pytest
import time
import socket
import base64
from datetime import datetime

from appium import webdriver
from appium.webdriver.webdriver import WebDriver


@pytest.fixture(scope="session", autouse=True)
def desired_capabilities() -> dict:
    return {
        "bundleId": "com.toiletsnakes.Card",
        "deviceName": "iPhone 8",
        "udid": "1BDA0BD6-A0F6-4C4F-AF7D-94F3EDDDE29A",
        "platformVersion": "13.0",
        "platformName": "iOS",
        "noReset": True
    }


@pytest.fixture(scope="session", autouse=True)
def driver(desired_capabilities: dict) -> WebDriver:
    hostname = socket.gethostname()
    ip = socket.gethostbyname(hostname)

    EXECUTOR = f"http://{ip}:4723/wd/hub"

    driver = webdriver.Remote(
        command_executor=EXECUTOR,
        desired_capabilities=desired_capabilities,
        direct_connection=True
    )

    return driver


@pytest.fixture(scope="session", autouse=True)
def page(driver: WebDriver) -> None:
    from page.page import Page as Page
    Page.driver = driver


@pytest.fixture(scope="function", autouse=True)
def video(driver: WebDriver, request) -> None:
    driver.start_recording_screen(videoType="mpeg4", bugReport=True)
    yield

    now = datetime.now()
    date_string = now.strftime("%Y-%m-%d_%H:%M:%S")

    video_name: str = f"{request.node.name}_{date_string}"

    with open(f"videos/{video_name}.mp4", "wb") as f:
        video: str = driver.stop_recording_screen()
        f.write(base64.b64decode(video))
