#!/usr/bin/python
# -*- coding:utf-8 -*-

from lib.waveshare_epd import epd7in5_V2
from PIL import Image, ImageDraw, ImageFont
import traceback
import time
import logging
import sys
import os

logging.basicConfig(level=logging.DEBUG)

try:
    logging.info("epd7in5_V2 Demo")
    epd = epd7in5_V2.EPD()

    logging.info("init and Clear")
    epd.init()
    epd.Clear()

    logging.info("3.read png file")
    Himage = Image.open(os.path.join(
        os.path.dirname(__file__), 'billboard.png'))
    epd.display(epd.getbuffer(Himage))
    time.sleep(2)

    logging.info("Clear...")
    epd.init()
    epd.Clear()

    logging.info("Goto Sleep...")
    epd.sleep()

except IOError as e:
    logging.info(e)

except KeyboardInterrupt:
    logging.info("ctrl + c:")
    epd7in5_V2.epdconfig.module_exit()
    exit()
