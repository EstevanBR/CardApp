import pytest
from page.page import PageObjectNotFound
from pages.card_page import CardPage
from pages.questions_page import QuestionsPage
from pages.answer_cell_page import AnswerCellPage
from report.report import Report


@pytest.mark.ios
class TestCardPage:
    @pytest.fixture(scope="function", autouse=True)
    def setup(self):
        try:
            QuestionsPage()
        except PageObjectNotFound:
            CardPage().dismiss_via_swipe()

    def test_get_card_page(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .dismiss_via_swipe()
        )
        assert QuestionsPage()

    @pytest.mark.audio
    def test_record_turns_into_square(self, report: Report):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_record_button()
            .sleep(3)
            .tap_record_button()
            .dismiss_via_swipe()
        )
        assert QuestionsPage()

    def test_card_has_question_mark(self, report: Report):
        (
            QuestionsPage()
            .tap_answer_cell()
            .get_question_text(
                lambda text: report.soft_assert("?" in text, "HW-000", "Questions should have a '?'")
            )
        )
        assert QuestionsPage()

    @pytest.mark.audio
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

    def test_tap_question_cell(self):
        (
            QuestionsPage()
            .get_question_cell()
            .tap()
        )
        assert QuestionsPage()

    @pytest.mark.audio
    def test_dismiss_while_recording(self):
        (
            QuestionsPage()
            .tap_answer_cell()
            .tap_record_button()
            .sleep(1)
            .dismiss_via_swipe()
        )

    def test_answer_cell_has_answer_a_question_text(self, report: Report):
        (
            AnswerCellPage()
            .get_answer_cell_text(
                lambda text: report.soft_assert("Answer a Question" == text, "HW-001", "Answer cell text should be 'Answer a Question'")
            )
        )
