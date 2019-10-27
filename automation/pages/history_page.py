from __future__ import annotations
from page.page import Page as Page


class HistoryPage(Page):
    root: str = "QuestionsTableViewController.tableView"

    def get_answer_cell(self) -> AnswerCellPage:
        from pages.answer_cell_page import AnswerCellPage
        return AnswerCellPage()
