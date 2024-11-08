import time
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

def send_whatsapp_message(apk_path, recipient_number):
    # Setup Chrome WebDriver
    options = webdriver.ChromeOptions()
    options.add_argument("--user-data-dir=./chrome_data")  # To persist WhatsApp session
    options.add_argument("--profile-directory=Default")  # Use default profile

    driver = webdriver.Chrome(ChromeDriverManager().install(), options=options)
    driver.get("https://web.whatsapp.com/")
    print("Please scan the QR code to log in to WhatsApp Web...")

    # Wait for QR scan
    time.sleep(15)

    # Find the contact by phone number
    search_box = driver.find_element(By.XPATH, '//div[@contenteditable="true"][@data-tab="3"]')
    search_box.click()
    search_box.send_keys(recipient_number)
    search_box.send_keys(Keys.ENTER)
    time.sleep(2)

    # Attach and send the APK file
    attach_button = driver.find_element(By.XPATH, '//div[@title="Attach"]')
    attach_button.click()
    time.sleep(1)

    file_input = driver.find_element(By.XPATH, '//input[@type="file"]')
    file_input.send_keys(apk_path)
    time.sleep(2)

    send_button = driver.find_element(By.XPATH, '//span[@data-icon="send"]')
    send_button.click()
    print(f"Sent APK to {recipient_number} successfully.")

    # Close browser
    time.sleep(5)
    driver.quit()

if __name__ == "__main__":
    apk_path = "/path/to/your/flutter/app-release.apk"  # Path to your built APK
    recipient_number = "9766190540"  # Recipient WhatsApp number (with country code)
    send_whatsapp_message(apk_path, recipient_number)
