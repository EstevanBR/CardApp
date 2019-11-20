from __future__ import annotations
from page.page import Page
from appium.webdriver.common.mobileby import MobileBy


class QuestionCellPage(Page):
    @property
    def __cell(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "QuestionCell"))

    @property
    def __questionLabel(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "QuestionCell.questionLabel"))

    def __init__(self):
        assert self.__cell.is_displayed()

    def tap(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage

        self.__cell.click()
        return QuestionsPage()
