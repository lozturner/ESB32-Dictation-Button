# ESB32-Dictation-Button

**Roaming USB dictation button using ESP32-S3 with native USB HID. Press button, trigger dictation shortcut anywhere on Windows.**

## What is ESB32?

ESB32 (ESP32 Button) is a simple hardware button that acts as a USB keyboard. When you press it, it sends a keyboard shortcut (Ctrl+Win+Space by default) to activate dictation on Windows. No software installation needed on your PC—just plug it in and press the button.

### Why Build This?

- **Roaming dictation**: Trigger voice input from anywhere, even if you're away from your keyboard
- **Universal compatibility**: Works as a standard USB keyboard—no drivers, no configuration
- **Simple hardware**: Uses ESP32-S3 dev board with native USB HID support
- **Customizable**: Change the shortcut in the Arduino sketch to match your dictation app

## Hardware Requirements

- **ESP32-S3 dev board** with native USB support (recommended)
  - Must have USB-OTG capability (native USB HID)
  - Example: ESP32-S3 DevKitC-1
- **Push button** (any normally-open momentary switch)
- **Wiring**: Button connected between GPIO pin and GND

**Note**: ESP32-C3 Super Mini can also work but requires additional configuration for USB HID.

## Quick Start

### 1. Install Arduino IDE and ESP32 Support

Run this PowerShell script (as Administrator) to install everything:

```powershell
# Install winget if not present
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Installing winget..."
    Start-Process "ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"
    Write-Host "Please install App Installer from the Store, then re-run this script."
    exit
}

# Install Arduino IDE
Write-Host "Installing Arduino IDE..."
winget install --id=ArduinoSA.IDE.stable -e --accept-source-agreements --accept-package-agreements

# Install Git
Write-Host "Installing Git..."
winget install --id=Git.Git -e --accept-source-agreements --accept-package-agreements

Write-Host "Installation complete. Please restart your terminal and Arduino IDE."
```

### 2. Configure Arduino IDE

1. Open Arduino IDE
2. Go to **File → Preferences**
3. Add this URL to "Additional Board Manager URLs":
   ```
   https://espressif.github.io/arduino-esp32/package_esp32_index.json
   ```
4. Go to **Tools → Board → Boards Manager**
5. Search for "esp32" and install "**esp32 by Espressif Systems**" (version 2.0.0 or newer)

### 3. Upload the Firmware

1. Connect your ESP32-S3 to your computer via **UART USB port**
2. Open Arduino IDE
3. Create a new sketch and paste the code from `ESB32_Dictation.ino` (see below)
4. Select **Tools → Board → ESP32 Arduino → ESP32S3 Dev Module**
5. Configure these settings:
   - **USB CDC On Boot**: Enabled
   - **USB Mode**: USB-OTG (TinyUSB)
   - **Port**: Select the COM port associated with the UART USB connector
6. Click **Upload**
7. After upload completes:
   - **Unplug from UART port**
   - **Plug into the S3 native USB port**
   - Windows will enumerate it as a keyboard

### 4. Test the Button

1. Open any text field
2. Press the physical button on your ESP32
3. Windows dictation should activate

## Arduino Sketch

See `ESB32_Dictation.ino` for the complete code. Key features:
- USB HID keyboard emulation
- Button debouncing
- Sends Ctrl+Win+Space by default
- Easy to customize

## Customization

### Change the Keyboard Shortcut

Edit the key press lines in the sketch:

```cpp
// For Win+H (Windows 10/11 dictation):
Keyboard.press(KEY_LEFT_GUI);
Keyboard.press('h');
```

### Change the Button Pin

Modify the `BUTTON_PIN` constant:

```cpp
const int BUTTON_PIN = 4;  // Use GPIO4 instead of GPIO0
```

## Troubleshooting

### Windows Doesn't Recognize the Device

- Ensure you're plugged into the **native USB port**
- Check **USB CDC On Boot** is **Enabled** in Arduino IDE
- Check **USB Mode** is set to **USB-OTG (TinyUSB)**

### Button Press Doesn't Trigger Dictation

- Verify your Windows dictation shortcut in Settings
- Check button wiring: Should connect GPIO pin to GND when pressed

### Upload Fails

- Make sure you're uploading via the **UART USB port**
- Hold the BOOT button while clicking Upload if auto-reset fails

## Project Structure

```
ESB32-Dictation-Button/
├── README.md              # This file
├── ESB32_Dictation.ino    # Arduino sketch
└── setup_windows.ps1      # PowerShell setup script
```

## Future Enhancements

- [ ] 3D-printable case design
- [ ] Multi-button support
- [ ] LED feedback for button press
- [ ] Battery operation with deep sleep
- [ ] Configuration via web interface

## License

MIT License - feel free to use, modify, and distribute.

## Contributing

Pull requests welcome! Please ensure your code follows the existing style and includes comments.

---

**Built by TurnerWorks** | [Report Issues](https://github.com/lozturner/ESB32-Dictation-Button/issues)
