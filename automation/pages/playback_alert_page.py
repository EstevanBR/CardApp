from __future__ import annotations
from page.page import Page as Page
from xcui_element.xcui_element_types import XCUIElementType


class PlaybackAlertPage(Page):
    name: str = "Audio Ouput"
    class_name: str = XCUIElementType.Sheet

    def __init__(self):
        self._element: WebElement = Page.driver.find_element_by_class_name(self.class_name)
        assert self._element.is_displayed()

    def tap_default(self) -> CardPage:
        from pages.card_page import CardPage

        self._element.find_element_by_name("Default").click()
        return CardPage()

    def tap_speaker(self) -> CardPage:
        from pages.card_page import CardPage

        self._element.find_element_by_name("Speaker").click()
        return CardPage()
