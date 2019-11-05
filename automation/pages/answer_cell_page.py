from __future__ import annotations
from page.page import Page
from typing import Tuple
from appium.webdriver.common.mobileby import MobileBy


class AnswerCellPage(Page):
    _root: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "AnswerCell")
    __textLabel: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "AnswerCell.actionLabel")

    def tap(self) -> CardPage:
        from pages.card_page import CardPage
        self._element.click()
        return CardPage()

    def get_answer_cell_text(self, text_callback: Callable[[str]]) -> AnswerCellPage:
        text_callback(Page.find_element(self.__textLabel).text)
        return AnswerCellPage()
