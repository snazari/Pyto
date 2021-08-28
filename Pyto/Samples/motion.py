"""
Access the pitch of the device.
"""

import motion
from math import pi
rad2deg = float(180/(2*pi))

motion.start_updating()

while True:
    a = motion.get_attitude()
    roll = round(a.roll*rad2deg,2)
    pitch= round(a.pitch*rad2deg,2)
    yaw  = round(a.yaw*rad2deg,2)
    
    arrow = ""
    if pitch < 0:
        arrow = "↑"
    elif pitch > 0:
        arrow = "↓"
    
    print(f"\rRoll: "+str(roll), end=" ")
    print(f"Pitch: "+str(pitch), end=" ")
    print(f"Yaw: "+str(yaw), end="")
