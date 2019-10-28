from __future__ import annotations
from page.page import Page as Page


class QuestionsPage(Page):
    identifier: str = "QuestionsTableViewController.tableView"

    def tap_answer_cell(self) -> CardPage:
        from pages.card_page import CardPage
        from pages.answer_cell_page import AnswerCellPage

        AnswerCellPage().tap()

        return CardPage()

    def tap_question_cell(self) -> QuestionsPage:
        from pages.question_cell_page import QuestionCellPage

        QuestionCellPage().tap()
        return QuestionsPage()

    def get_question_cell(self) -> QuestionCellPage:
        from pages.question_cell_page import QuestionCellPage

        return QuestionCellPage()
