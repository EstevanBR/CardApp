from __future__ import annotations
from page.page import Page


class AnswerCellPage(Page):
    _identifier: str = "AnswerCell.view"
    textLabel: str = "AnswerCell.textLabel"

    def tap(self) -> CardPage:
        from pages.card_page import CardPage
        self._element.click()
        return CardPage()
