from typing import List
import logging


class TestReport:
    failures: List[str]
    errors: dict
    successes: List[str]

    def __init__(self):
        self.errors = {}  # list of dict
        self.successes = []
        self.failures = []

    def report(self, key: str, status: bool, message: str = None):
        if status is True:
            self.successes.append(key)
        else:
            self.failures.append(key)

    def soft_assert(self, test_expression: bool, key: str, message: str):
        try:
            assert test_expression
        except AssertionError:
            self.failures.append(key)
            if message is not None:
                self.errors[key] = message
        else:
            self.successes.append(key)

    def passed(self) -> bool:
        return len(self.failures) == 0

    def finalize(self):
        logging.info(f"\nsuccesses: {self.successes}\nfailures: {self.failures}\nerrors: {self.errors}")
