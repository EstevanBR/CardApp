from __future__ import annotations

import time

from appium.webdriver import WebElement
from appium.webdriver.webdriver import WebDriver

from typing import Callable


class Page:
    __driver: WebDriver
    _identifier: str

    @classmethod
    def inject_driver(cls, driver: WebDriver):
        cls.__driver = driver

    @classmethod
    def find_element_by_accessibility_id(cls, accessibility_id: str) -> WebElement:
        return Page.__driver.find_element_by_accessibility_id(accessibility_id)

    def __init__(self):
        self._element: WebElement = Page.__driver.find_element_by_accessibility_id(self._identifier)
        assert self._element.is_displayed()

    def sleep(self, duration: float):
        time.sleep(duration)
        return self

    def _swipe_down(self):
        Page.__driver.execute_script("mobile: swipe", {"direction": "down"})

    def test(self, value: bool) -> Page:
        assert value is True
        return self

    def test_expression(self, expression: Callable[[Page], bool]) -> Page:
        assert expression(self)
        return self
