from __future__ import annotations
from page.page import Page as Page
from appium.webdriver.common.mobileby import MobileBy
from appium.webdriver.webelement import WebElement


class QuestionsPage(Page):
    @property
    def __view(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "QuestionsTableViewController.view"))

    def __init__(self):
        assert self.__view.is_displayed()

    def tap_answer_cell(self) -> AnswerCellPage:
        from pages.card_page import CardPage
        from pages.answer_cell_page import AnswerCellPage

        AnswerCellPage().tap()
        return CardPage()

    def get_question_cell(self) -> QuestionCellPage:
        from pages.question_cell_page import QuestionCellPage

        return QuestionCellPage()
