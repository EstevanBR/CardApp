from __future__ import annotations

from typing import Tuple

from appium.webdriver.common.mobileby import MobileBy

from page.page import Page as Page
# from xcui_element.xcui_element_types import XCUIElementType


class PlaybackAlertPage(Page):
    _root: Tuple[MobileBy, str] = (MobileBy.NAME, "Audio Output")

    # _class_name: str = XCUIElementType.Sheet

    def tap_default(self) -> CardPage:
        from pages.card_page import CardPage

        self._element.find_element_by_name("Default").click()
        return CardPage()

    def tap_speaker(self) -> CardPage:
        from pages.card_page import CardPage

        self._element.find_element_by_name("Speaker").click()
        return CardPage()
