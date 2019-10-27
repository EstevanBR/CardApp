from __future__ import annotations
from page.page import Page


class QuestionCellPage(Page):
    identifier: str = "QuestionCell.view"
    questionLabel: str = "QuestionCell.questionLabel"
    playButton: str = "QuestionCell.playButton"

    def tap(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage
        self.element.click()
        return QuestionsPage()

    def tap_play_button(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage
        self.driver.find_element_by_accessibility_id(self.playButton).click()
        return QuestionsPage()
