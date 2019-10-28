from pages.questions_page import QuestionsPage
from pages.question_cell_page import QuestionCellPage


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
        QuestionsPage().tap_question_cell()
        QuestionCellPage().tap()
        assert QuestionsPage()
