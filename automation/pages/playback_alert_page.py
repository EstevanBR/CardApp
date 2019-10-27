from __future__ import annotations
from page.page import Page as Page


class PlaybackAlertPage(Page):
    root: str = "CardViewController.audioAlert"

    def tap_default(self) -> CardPage:
        from pages.card_page import CardPage
        self.element.find_element_by_name("Default").click()
        return CardPage()

    def tap_speaker(self) -> CardPage:
        from pages.card_page import CardPage
        self.element.find_element_by_name("Speaker").click()
        return CardPage()
