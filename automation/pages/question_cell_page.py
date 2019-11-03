from __future__ import annotations
from page.page import Page


class QuestionCellPage(Page):
    _identifier: str = "QuestionCell"
    questionLabel: str = "QuestionCell.questionLabel"
    playButton: str = "QuestionCell.playButton"

    def tap(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage

        self._element.click()
        return QuestionsPage()

    def tap_play_button(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage

        Page.find_element_by_accessibility_id(self.playButton).click()
        return QuestionsPage()
