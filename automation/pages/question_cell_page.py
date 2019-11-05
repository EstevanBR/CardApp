from __future__ import annotations
from page.page import Page
from typing import Tuple
from appium.webdriver.common.mobileby import MobileBy


class QuestionCellPage(Page):
    _root: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "QuestionCell")
    __questionLabel: Tuple[MobileBy, str] = (MobileBy.ACCESSIBILITY_ID, "QuestionCell.questionLabel")

    def tap(self) -> QuestionsPage:
        from pages.questions_page import QuestionsPage

        self._element.click()
        return QuestionsPage()
