/*
 * ESB32 Dictation Button
 * 
 * Roaming USB dictation button using ESP32-S3 with native USB HID.
 * Press button, trigger dictation shortcut anywhere on Windows.
 * 
 * Hardware:
 * - ESP32-S3 dev board with native USB support
 * - Push button connected between GPIO and GND
 * 
 * Author: TurnerWorks
 * License: MIT
 * Repository: https://github.com/lozturner/ESB32-Dictation-Button
 */

#include "USB.h"
#include "USBHIDKeyboard.h"

USBHIDKeyboard Keyboard;

// Configuration
const int BUTTON_PIN = 0;  // GPIO0 - change to match your wiring
const int DEBOUNCE_DELAY = 50;  // milliseconds

// State tracking
int lastButtonState = HIGH;
int buttonState;
unsigned long lastDebounceTime = 0;

void setup() {
  // Initialize button pin with internal pull-up
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  
  // Initialize USB HID Keyboard
  Keyboard.begin();
  USB.begin();
}

void loop() {
  // Read button state
  int reading = digitalRead(BUTTON_PIN);
  
  // Debounce logic
  if (reading != lastButtonState) {
    lastDebounceTime = millis();
  }
  
  if ((millis() - lastDebounceTime) > DEBOUNCE_DELAY) {
    // If button state has changed
    if (reading != buttonState) {
      buttonState = reading;
      
      // Only trigger on button press (LOW, because of INPUT_PULLUP)
      if (buttonState == LOW) {
        // Send Ctrl+Win+Space (Windows dictation shortcut)
        Keyboard.press(KEY_LEFT_CTRL);
        Keyboard.press(KEY_LEFT_GUI);  // Windows key
        Keyboard.press(' ');
        delay(100);  // Hold for 100ms
        Keyboard.releaseAll();
      }
    }
  }
  
  lastButtonState = reading;
}
