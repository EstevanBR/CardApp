import pytest
import logging
from _pytest.config import Config


def pytest_addoption(parser):
    parser.addoption("--deviceName", dest="deviceName", action="store", required=True)
    parser.addoption("--udid", dest="udid", action="store", required=True)
    parser.addoption("--platformVersion", dest="platformVersion", action="store", required=True)
    parser.addoption("--wdaLocalPort", dest="wdaLocalPort", action="store", required=True)
    parser.addoption("--app", type="string", dest="app", action="store", required=False, default="/Users/ehernandez/Desktop/Build/Products/Debug-iphonesimulator/Card.app/")
    parser.addoption("--derivedDataPath", type="string", dest="derivedDataPath", action="store", required=False, default="/Users/ehernandez/Library/Developer/Xcode/DerivedData/WebDriverAgent-ciegwgvxzxdrqthilmrmczmqvrgu")


@pytest.fixture(scope="module", autouse=False)
def noReset() -> bool:
    return True


@pytest.fixture(scope="module", autouse=False)
def fullReset() -> bool:
    return False


class DesiredCapabilities(dict):
    bundleId: str
    app: str
    deviceName: str
    udid: str
    platformVersion: str
    wdaLocalPort: str
    platformName: str
    noReset: bool
    fullReset: bool
    newCommandTimeout: int
    autoLaunch: bool
    autoAcceptAlerts: bool
    derivedDataPath: str
    processArguments: dict

    def __init__(self):
        pass


@pytest.fixture(scope="module", autouse=False)
def desired_capabilities(noReset: bool, fullReset: bool, pytestconfig: Config) -> dict:
    desired_capabilities = {
        "bundleId": "com.toiletsnakes.Card",
        "app": pytestconfig.option.app,
        "deviceName": pytestconfig.option.deviceName,
        "udid": pytestconfig.option.udid,
        "platformVersion": pytestconfig.option.platformVersion,
        "wdaLocalPort": pytestconfig.option.wdaLocalPort,
        "platformName": "iOS",
        "noReset": noReset,
        "fullReset": fullReset,
        "newCommandTimeout": 60,
        "autoLaunch": False,
        "autoAcceptAlerts": True,
        "derivedDataPath": pytestconfig.option.derivedDataPath,
        "processArguments": {
            "args": [
                "RESET"
            ],
            "env": {

            }
        }
    }
    logging.debug(f"desired_capabilities\n{desired_capabilities}")
    return desired_capabilities
