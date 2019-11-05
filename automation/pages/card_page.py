from __future__ import annotations
from page.page import Page as Page
from typing import Callable, Tuple
from appium.webdriver.common.mobileby import MobileBy


class CardPage(Page):
    _root: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.view")
    __questionLabel: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.questionLabel")
    __currentCardLabel: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.currentCardLabel")
    __completedLabel: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.completedLabel")
    __prevCardButton: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.prevCardButton")
    __nextCardButton: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.nextCardButton")
    __completeCardButton: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.completeCardButton")
    __recordButton: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.recordButton")
    __playButton: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "CardView.playButton")

    def tap_record_button(self) -> CardPage:
        Page.find_element(self.__recordButton).click()
        return CardPage()

    def tap_complete_card_button(self) -> CardPage:
        Page.find_element(self.__completeCardButton).click()
        return CardPage()

    def get_record_button_text(self) -> CardPage:
        Page.find_element(self.__recordButton).text()
        return CardPage()

    def tap_play_button(self) -> CardPage:
        Page.find_element(self.__playButton).click()
        return CardPage()

    def get_play_button_text(self) -> CardPage:
        Page.find_element(self.__playButton).text()
        return CardPage()

    def dismiss_via_swipe(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage

        self._swipe_down()
        return QuestionsPage()

    def get_question_text(self, text_callback: Callable[[str]]) -> CardPage:
        text_callback(Page.find_element(self.__questionLabel).text)
        return CardPage()
