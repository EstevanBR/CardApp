from typing import List
import logging


class Report:
    failures: List[str]
    errors: dict
    successes: List[str]

    def __init__(self):
        self.errors = {}  # list of dict
        self.successes = []
        self.failures = []

    def soft_assert(self, statement: bool, key: str, message: str):
        try:
            assert statement
        except AssertionError as e:
            logging.info(e)
            self.failures.append(key)
            if message is not None:
                self.errors[key] = message
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
