from pages.questions_page import QuestionsPage
from pages.card_page import CardPage
from selenium.common.exceptions import ElementNotVisibleException
import pytest


class TestCardPage:
    @pytest.fixture(scope="function", autouse=True)
    def setup(self):
        try:
            QuestionsPage()
        except ElementNotVisibleException:
            CardPage().dismiss_via_swipe()

    def test_get_card_page(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_history_button()
        )
        assert QuestionsPage()

    def test_record_turns_into_square(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .get_question_text(
                lambda card, text: card.test("?" in text)
            )
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .tap_history_button()
        )
        assert QuestionsPage()

    def test_record_and_play(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .tap_play_button()
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

    def test_complete_question_card(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_complete_card_button()
            .dismiss_via_swipe()
        )

    def test_question_cell_play_button(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_complete_card_button()
            .dismiss_via_swipe()
            .get_question_cell()
            .tap_play_button()
        )
        assert QuestionsPage()

    def test_tap_question_cell(self):
        QuestionsPage().get_question_cell().tap()
        assert QuestionsPage()

    def test_test(self):
        QuestionsPage().tap_answer_cell()
        try:
            CardPage().test_expression(lambda card: True is False)
        except AssertionError:
            pytest.xfail(reason="True is not False!")
            raise
