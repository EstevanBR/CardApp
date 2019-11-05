from __future__ import annotations

import time
from typing import Tuple

from appium.webdriver import WebElement
from appium.webdriver.common.mobileby import MobileBy
from appium.webdriver.webdriver import WebDriver
from selenium.common.exceptions import ElementNotVisibleException


class Error(Exception):
    """Base class for exceptions in this module."""
    pass


class PageObjectNotFound(Error):
    """Exception raised for errors in the input.

    Attributes:
        expression -- input expression in which the error occurred
        message -- explanation of the error
    """

    def __init__(self, expression):
        self.expression = expression
        self.message = f"Wasn't able to find WebElement using _identifier, _name, _classname, or _custom"


class MissingParam(Error):
    """Exception raised for errors in the input.

    Attributes:
        expression -- input expression in which the error occurred
        message -- explanation of the error
    """

    def __init__(self, expression):
        self.expression = expression
        self.message = "Expected _identifier, _name, or _class_name"


class Page:
    """Base class for PageObjects.

    Attributes:
        __driver: Webdriver
        _root: Tuple[MobileBy, str] -- the strategy used to find the elemend
        _element: WebElement -- the underlying WebElementObject
    """
    _root: Tuple[MobileBy, str]
    __driver: WebDriver
    _element: WebElement

    @classmethod
    def inject_driver(cls, driver: WebDriver):
        cls.__driver = driver

    @classmethod
    def find_element(cls, strategy: Tuple[MobileBy, str]) -> WebElement:
        return Page.__driver.find_element(*strategy)

    def __init__(self):
        try:
            self._element: WebElement = Page.__driver.find_element(*self._root)
        except ElementNotVisibleException:
            raise PageObjectNotFound()

    def sleep(self, duration: float):
        time.sleep(duration)
        return self

    def _swipe_down(self):
        Page.__driver.execute_script("mobile: swipe", {"direction": "down"})
