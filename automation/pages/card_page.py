from __future__ import annotations
from page.page import Page as Page
from typing import Callable


class CardPage(Page):
    _identifier: str = "CardView.view"
    questionLabel: str = "CardView.questionLabel"
    currentCardLabel: str = "CardView.currentCardLabel"
    completedLabel: str = "CardView.completedLabel"
    prevCardButton: str = "CardView.prevCardButton"
    nextCardButton: str = "CardView.nextCardButton"
    completeCardButton: str = "CardView.completeCardButton"
    recordButton: str = "CardView.recordButton"
    playButton: str = "CardView.playButton"
    historyButton: str = "CardView.historyButton"
    addCardButton: str = "CardView.addCardButton"

    def tap_record_button(self) -> CardPage:
        Page.find_element_by_accessibility_id(self.recordButton).click()
        return CardPage()

    def tap_complete_card_button(self) -> CardPage:
        Page.find_element_by_accessibility_id(self.completeCardButton).click()
        return CardPage()

    def get_record_button_text(self) -> CardPage:
        Page.find_element_by_accessibility_id(self.recordButton).text()
        return CardPage()

    def tap_play_button(self) -> CardPage:
        Page.find_element_by_accessibility_id(self.playButton).click()
        return CardPage()

    def get_play_button_text(self) -> CardPage:
        Page.find_element_by_accessibility_id(self.playButton).text()
        return CardPage()

    def tap_history_button(self) -> CardPage:
        from pages.questions_page import QuestionsPage

        Page.find_element_by_accessibility_id(self.historyButton).click()
        return QuestionsPage()

    def dismiss_via_swipe(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage

        self._swipe_down()
        return QuestionsPage()

    def get_question_text(self, text_callback: Callable[[CardPage, str]]) -> CardPage:
        text_callback(self, Page.find_element_by_accessibility_id(self.questionLabel).text)
        return CardPage()
