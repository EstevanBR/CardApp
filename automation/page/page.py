from __future__ import annotations
from appium import webdriver
from appium.webdriver import WebElement
from appium.webdriver.webdriver import WebDriver
from selenium.common.exceptions import NoSuchElementException
import pytest
import time


class Page:
    """

    Page class

    Attributes:
        driver: Webdriver
        element: WebElement

    """

    driver: WebDriver = None
    root: str
    element: WebElement

    @classmethod
    def Page(driver: WebDriver):
        driver = driver

    def __init__(self):
        self.element: WebElement = Page.driver.find_element_by_accessibility_id(self.root)
        assert self.element.is_displayed()

    def sleep(self, duration: float):
        time.sleep(duration)
        return self
