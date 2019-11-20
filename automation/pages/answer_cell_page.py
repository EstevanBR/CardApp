from __future__ import annotations
from page.page import Page, TextCallback
from appium.webdriver.common.mobileby import MobileBy
from appium.webdriver.webelement import WebElement


class AnswerCellPage(Page):
    @property
    def __cell(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "AnswerCell"))

    @property
    def __textLabel(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "AnswerCell.actionLabel"))

    def __init__(self):
        assert self.__cell.is_displayed()

    def tap(self) -> CardPage:
        from pages.card_page import CardPage
        self.__cell.click()
        return CardPage()

    def get_answer_cell_text(self, text_callback: TextCallback) -> AnswerCellPage:
        text_callback(self.__textLabel.text)
        return AnswerCellPage()
