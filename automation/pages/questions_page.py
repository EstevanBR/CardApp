from __future__ import annotations
from page.page import Page as Page
from typing import Tuple
from appium.webdriver.common.mobileby import MobileBy


class QuestionsPage(Page):
    _root: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "QuestionsTableViewController.view")

    def tap_answer_cell(self) -> AnswerCellPage:
        from pages.card_page import CardPage
        from pages.answer_cell_page import AnswerCellPage

        AnswerCellPage().tap()
        return CardPage()

    def get_question_cell(self) -> QuestionCellPage:
        from pages.question_cell_page import QuestionCellPage

        return QuestionCellPage()
