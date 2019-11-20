from __future__ import annotations
from page.page import Page, TextCallback
from appium.webdriver.common.mobileby import MobileBy
from appium.webdriver.webelement import WebElement


class CardPage(Page):
    @property
    def __view(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.view"))

    @property
    def __questionLabel(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.questionLabel"))

    @property
    def __currentCardLabel(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.currentCardLabel"))

    @property
    def __completedLabel(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.completedLabel"))

    @property
    def __prevCardButton(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.prevCardButton"))

    @property
    def __nextCardButton(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.nextCardButton"))

    @property
    def __completeCardButton(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.completeCardButton"))

    @property
    def __recordButton(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.recordButton"))

    @property
    def __playButton(self) -> WebElement:
        return Page.find_element((MobileBy.ACCESSIBILITY_ID, "CardView.playButton"))

    def __init__(self):
        assert self.__view.is_displayed()

    def tap_record_button(self) -> CardPage:
        self.__recordButton.click()
        return CardPage()

    def tap_complete_card_button(self) -> CardPage:
        self.__completeCardButton.click()
        return CardPage()

    def get_record_button_text(self) -> CardPage:
        self.__recordButton.text()
        return CardPage()

    def tap_play_button(self) -> CardPage:
        self.__playButton.click()
        return CardPage()

    def get_play_button_text(self) -> CardPage:
        self.__playButton.text()
        return CardPage()

    def dismiss_via_swipe(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage

        self._swipe_down()
        return QuestionsPage()

    def get_question_text(self, text_callback: TextCallback) -> CardPage:
        text_callback(self.__questionLabel.text)
        return CardPage()
