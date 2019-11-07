import pytest
import logging


def pytest_addoption(parser):
    parser.addoption("--deviceName", dest="deviceName", action="store", required=True)
    parser.addoption("--udid", dest="udid", action="store", required=True)
    parser.addoption("--platformVersion", dest="platformVersion", action="store", required=True)
    parser.addoption("--wdaLocalPort", dest="wdaLocalPort", action="store", required=True)


@pytest.fixture(scope="session", autouse=False)
def bundleId() -> str:
    return "com.toiletsnakes.Card"


@pytest.fixture(scope="session", autouse=False)
def app() -> str:
    return "/Users/ehernandez/Desktop/Build/Products/Debug-iphonesimulator/Card.app/"


@pytest.fixture(scope="session", autouse=False)
def platformName() -> str:
    return "iOS"


@pytest.fixture(scope="session", autouse=False)
def derivedDataPath() -> str:
    return "/Users/ehernandez/Library/Developer/Xcode/DerivedData/WebDriverAgent-ciegwgvxzxdrqthilmrmczmqvrgu"


@pytest.fixture(scope="session", autouse=False)
def noReset() -> bool:
    return True


@pytest.fixture(scope="session", autouse=False)
def fullReset() -> bool:
    return False


@pytest.fixture(scope="session", autouse=False)
def desired_capabilities(
    bundleId: str,
    app: str,
    platformName: str,
    noReset: bool,
    fullReset: bool,
    derivedDataPath: str,
    pytestconfig
) -> dict:
    desired_capabilities = {
        "bundleId": bundleId,
        "app": app,
        "deviceName": pytestconfig.option.deviceName,
        "udid": pytestconfig.option.udid,
        "platformVersion": pytestconfig.option.platformVersion,
        "wdaLocalPort": pytestconfig.option.wdaLocalPort,
        "platformName": platformName,
        "noReset": noReset,
        "fullReset": fullReset,
        "newCommandTimeout": 60,
        "autoLaunch": False,
        "autoAcceptAlerts": True,
        "derivedDataPath": derivedDataPath,
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
