import pytest
import logging
from page.page import Page
from appium.webdriver.webdriver import WebDriver


@pytest.fixture(scope="function", autouse=True)
def page(driver: WebDriver) -> None:
    logging.debug(f"providing Page class with driver")
    Page.inject_driver(driver)
