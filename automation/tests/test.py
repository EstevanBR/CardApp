import logging
import time

import pytest
from appium import webdriver
from appium.webdriver import WebElement
from appium.webdriver.webdriver import WebDriver

from pages.questions_page import QuestionsPage
from pages.card_page import CardPage


class TestCardPage:
    def test_get_card_page(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_history_button()
        )
        assert QuestionsPage()

    def test_record(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .tap_history_button()
        )
        assert QuestionsPage()

    def test_record_and_play_default(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .tap_play_button()
            .tap_default()
            .sleep(3)
            .tap_history_button()
        )
        assert QuestionsPage()

    def test_record_and_play_speaker(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .tap_play_button()
            .tap_speaker()
            .sleep(3)
            .tap_history_button()
        )
        assert QuestionsPage()

    def test_dismiss_card_view_swipe(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .dismiss_via_swipe()
        )
        assert QuestionsPage()
