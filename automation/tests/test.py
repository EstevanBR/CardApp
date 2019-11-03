from pages.questions_page import QuestionsPage
from pages.card_page import CardPage
from page.page import PageNotFound
from test_report.test_report import TestReport
import pytest


@pytest.fixture(scope="function", autouse=False)
def test_report() -> TestReport:
    return TestReport()


@pytest.fixture(scope="function", autouse=True)
def report_tests(test_report: TestReport) -> None:
    yield None
    test_report.finalize()
    assert test_report.passed() is True


@pytest.fixture(scope="function", autouse=True)
def setup():
    try:
        QuestionsPage()
    except PageNotFound:
        CardPage().dismiss_via_swipe()


class TestCardPage:
    def test_get_card_page(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .dismiss_via_swipe()
        )
        assert QuestionsPage()

    def test_record_turns_into_square(self, test_report):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .dismiss_via_swipe()
        )
        assert QuestionsPage()

    def test_card_has_question_mark(self, test_report):
        (
            QuestionsPage()
            .tap_answer_cell()
            .get_question_text(
                lambda text: test_report.soft_assert("?" in text, "KEY-123", "Questions have '?'")
            )
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
            .sleep(4)
            .dismiss_via_swipe()
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

