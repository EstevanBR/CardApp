from __future__ import annotations

import time

from appium.webdriver import WebElement
from appium.webdriver.webdriver import WebDriver
from selenium.common.exceptions import ElementNotVisibleException
from typing import Callable
from test_report.test_report import TestReport


class Error(Exception):
    """Base class for exceptions in this module."""
    pass


class PageNotFound(Error):
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
        _identifier: str -- the accessibility identifier used to find the element
        _name: str -- the name used to find the element
        _class_name: str -- the class_name used to find the element
        _custom: Callable[WebDriver, [WebElement]] -- custom callable to find the element
            usage: self._custom = lambda driver: driver.find_element_by_xpath()
        _element: WebElement -- the underlying WebElementObject
    """
    __driver: WebDriver
    _identifier: str
    _name: str
    _class_name: str
    _custom: Callable[WebDriver, [WebElement]]
    _element: WebElement

    @classmethod
    def inject_driver(cls, driver: WebDriver):
        cls.__driver = driver

    def __init__(self):
        try:
            if self._identifier is not None:
                self._element: WebElement = Page.__driver.find_element_by_accessibility_id(self._identifier)
            elif self._name is not None:
                self._element: WebElement = Page.__driver.find_element_by_name(self._name)
            elif self._classname is not None:
                self._element: WebElement = Page.__driver.find_element_by_classname(self._classname)
            elif self._custom is not None:
                self._element = _custom(Page.__driver)
            else:
                raise MissingParam()
        except ElementNotVisibleException:
            raise PageNotFound()

    @classmethod
    def find_element_by_accessibility_id(cls, accessibility_id) -> WebElement:
        return cls.__driver.find_element_by_accessibility_id(accessibility_id)

    def sleep(self, duration: float):
        time.sleep(duration)
        return self

    def _swipe_down(self):
        Page.__driver.execute_script("mobile: swipe", {"direction": "down"})
    

    # def test(self, value: bool) -> Page:
    #     assert value is True
    #     return self

    # def test_expression(self, expression: Callable[[Page], bool]) -> Page:
    #     assert expression(self)
    #     return self
