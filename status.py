import os
import subprocess
import json
import sys
import status
import tkinter as tk

def get_output(cmd):
    result = subprocess.run(cmd, stdout=subprocess.PIPE)
    return result.stdout.decode("utf-8")

if __name__=="__main__":
    res = {}
    # TIME
    time = get_output(["date", "+%a %d/%m/%y %H:%M:%S"])
    res["time"] = time[:-1]
    # BATTERY
    percentage = get_output(["acpi", "-b"]).split(", ")[1]
    res["battery"] = percentage[:-1]
    if "Charging" in get_output(["acpi", "-b"]): # i cba to write this well
        res["battery"] += " (charging)"
    # VOLUME
    value = float(get_output([
        "wpctl", "get-volume", "@DEFAULT_SINK@"
    ]).split(" ")[1])
    percentage = str(int(value*100))+"%"
    res["volume"] = percentage
    # BRIGHTNESS
    value = int(get_output(["brightnessctl", "get"]))
    max = int(get_output(["brightnessctl", "max"]))
    percentage = str(int(value*100/max))+"%"
    res["brightness"] = percentage
    # WINDOW
    res["window"] = json.loads(
            get_output(["hyprctl", "activewindow", "-j"])
    ).get("title")
    # WORKSPACE
    res["workspace"] = json.loads(
            get_output(["hyprctl", "activeworkspace", "-j"])
    ).get("id")
    output = "normal"
    for arg in sys.argv:
        if arg == "json": output = "json"
        if arg == "tk": output = "tk"
    match output:
        case "normal":
            for key, value in res.items():
                print(f"{key.upper()}: {value}")
        case "json":
            print(json.dumps(res))
        case "tk":
            root = tk.Tk()
            for key, value in res.items():
                tk.Label(root, text=f"{key.upper()}: {value}").pack()
            root.mainloop()
