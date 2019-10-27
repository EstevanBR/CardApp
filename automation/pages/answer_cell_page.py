from __future__ import annotations
from page.page import Page


class AnswerCellPage(Page):
    identifier: str = "AnswerCell.view"
    textLabel: str = "AnswerCell.textLabel"

    def tap(self) -> CardPage:
        from pages.card_page import CardPage
        self.element.click()
        return CardPage()
