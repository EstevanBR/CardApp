from __future__ import annotations
from page.page import Page as Page


class QuestionsPage(Page):
    root: str = "QuestionsTableViewController.tableView"

    def tap_answer_cell(self) -> CardPage:
        from pages.card_page import CardPage
        from pages.answer_cell_page import AnswerCellPage
        AnswerCellPage().tap()

        return CardPage()

