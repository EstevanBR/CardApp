import logging
from typing import List


class Report:
    failures: List[str]
    errors: dict
    successes: List[str]

    def __init__(self):
        self.errors = {}  # list of dict
        self.successes = []
        self.failures = []

    def _handle_assertion_error(self, e: AssertionError, key: str, message: str):
        logging.error(e)

        self.failures.append(key)

        self.errors[key] = self.errors.get(key, [])

        if message is not None:
            self.errors[key].append(message)

    def soft_assert(self, statement: bool, key: str, message: str):
        try:
            assert statement
        except AssertionError as e:
            self._handle_assertion_error(e, key, message)
        else:
            self.successes.append(key)

    def passed(self) -> bool:
        return len(self.failures) == 0

    def finalize(self):
        if self.successes != []:
            logging.info(f"\nsuccesses: {self.successes}")
        if self.failures != []:
            logging.error(f"failures: {self.failures}")
        if self.errors != {}:
            logging.error(f"errors: {self.errors}")
