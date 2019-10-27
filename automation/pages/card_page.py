from __future__ import annotations
from page.page import Page as Page


class CardPage(Page):
    identifier: str = "CardView.view"
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
        self.driver.find_element_by_accessibility_id(self.recordButton).click()
        return self

    def get_record_button_text(self) -> CardPage:
        self.driver.find_element_by_accessibility_id(self.recordButton).text()
        return self

    def tap_play_button(self) -> PlaybackAlertPage:
        from pages.playback_alert_page import PlaybackAlertPage

        self.driver.find_element_by_accessibility_id(self.playButton).click()
        return PlaybackAlertPage()

    def get_play_button_text(self) -> CardPage:
        self.driver.find_element_by_accessibility_id(self.playButton).text()
        return self

    def tap_history_button(self) -> CardPage:
        self.driver.find_element_by_accessibility_id(self.historyButton).click()
        return self

    def dismiss_via_swipe(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage

        self.driver.execute_script("mobile: swipe", {"direction": "down"})
        return QuestionsPage()
