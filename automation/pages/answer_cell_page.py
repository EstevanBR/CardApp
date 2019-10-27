from __future__ import annotations
from page.page import Page as Page


class AnswerCellPage(Page):
    root: str = "AnswerCell.view"
    textLabel: str = "AnswerCell.textLabel"

    def tap(self) -> CardPage:
        from pages.card_page import CardPage
        self.driver.find_element_by_accessibility_id(AnswerCellPage.root).click()
        return CardPage()
