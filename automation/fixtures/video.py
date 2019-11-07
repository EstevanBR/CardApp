import pytest
import logging
import base64
from datetime import datetime
from appium.webdriver.webdriver import WebDriver


@pytest.fixture(scope="function", autouse=True)
def video(driver: WebDriver, request):
    logging.debug(f"started recording video")
    driver.start_recording_screen(videoType="mpeg4", bugReport=True)
    yield

    now = datetime.now()
    date_string = now.strftime("%Y-%m-%d_%H:%M:%S")

    video_name: str = f"{request.node.name}_{date_string}"
    file_name: str = f"videos/{video_name}.mp4"
    with open(file_name, "wb") as f:
        video: str = driver.stop_recording_screen()
        f.write(base64.b64decode(video))
        logging.debug(f"saved video to file: {file_name}")
