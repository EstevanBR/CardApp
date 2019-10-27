import logging
import time

import pytest
from appium import webdriver
from appium.webdriver import WebElement
from appium.webdriver.webdriver import WebDriver

from pages.history_page import HistoryPage
from pages.card_page import CardPage


class TestCardPage:
    def test_get_card_page(self):
        (
            HistoryPage()
            .get_answer_cell()
            .tap()
        )
        assert CardPage()

    def test_record(self):
        (
            HistoryPage()
            .get_answer_cell()
            .tap()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
        )
        assert CardPage()

    def test_record_and_play_default(self):
        (
            HistoryPage()
            .get_answer_cell()
            .tap()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .tap_play_button()
            .tap_default()
            .sleep(3)
        )
        assert CardPage()

    def test_record_and_play_speaker(self):
        (
            HistoryPage()
            .get_answer_cell()
            .tap()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .tap_play_button()
            .tap_speaker()
            .sleep(3)
        )
        assert CardPage()
