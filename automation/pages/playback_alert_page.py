from __future__ import annotations

from appium.webdriver.common.mobileby import MobileBy
from appium.webdriver.webelement import WebElement

from page.page import Page as Page

from xcui_element.xcui_element_types import XCUIElementType


class PlaybackAlertPage(Page):
    @property
    def __alert(self) -> WebElement:
        return Page.find_element((MobileBy.CLASS_NAME, XCUIElementType.Alert))

    @property
    def __title(self) -> WebElement:
        return self.__alert.find_element((MobileBy.NAME, "Audio Output"))

    def __init__(self):
        assert self.__title.is_displayed()

    def tap_default(self) -> CardPage:
        from pages.card_page import CardPage

        self.__alert.find_element_by_name("Default").click()
        return CardPage()

    def tap_speaker(self) -> CardPage:
        from pages.card_page import CardPage

        self.__alert.find_element_by_name("Speaker").click()
        return CardPage()
