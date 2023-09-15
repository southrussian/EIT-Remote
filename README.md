#  EIT Remote

EIT Remote is a special iOS app for medical purposes. 
The relevance of the app is determined by the need to facilitate the work of the staff of medical institutions, providing the ability to conduct electronic document management of patients and examinations performed, and work with medical measuring devices.
As a medical measuring device, this paper considers an electrical impedance tomography apparatus for studying human lungs.
The goals of creating the system: providing medical personnel with tools for monitoring the condition of patients without constant bedside monitoring; simplification of work with patient documentation and generation of examination reports; achieving maximum efficiency in decision-making by medical personnel to ensure the well-being of the patient’s health and life.

To transfer images from the EIT device, the TCP/IP protocol is used, which ensures reliable and stable data transfer between devices. Each image is transferred as a BMP file, which contains information about each pixel in the image.
Transferring images begins with establishing a connection between the EIT device and the mobile application on iOS. For this, a TCP socket is used, which allows you to establish a two-way connection between devices. The connection is established by sending a “handshake” - any symbol, so that the EIT device detects a device ready to receive data. After the connection is established, the EIT device begins to transmit BMP images via a TCP socket.
Each data array consists of four bytes of left lung ventilation data, four bytes of respiratory rate data, a 54-byte header, and a pixel array. The header contains information about the file size, image resolution, number of colors and other parameters. A pixel array contains information about each pixel in an image, including color and brightness.
After receiving the BMP image, the iOS mobile application can display it on the device screen. To do this, an instance of the UIImage class processes the BMP file, extracting information about each pixel from it and using this information to create an image on the screen.

Stack: Swift, SwiftUI, Firebase.

Screenshots of working app below

<img width="420" alt="image" src="https://github.com/southrussian/EIT-Remote/assets/57446339/1dba9ec3-22b5-472f-89bb-969374d0a562">
<img width="479" alt="image" src="https://github.com/southrussian/EIT-Remote/assets/57446339/1bf41170-a6a7-4098-bb9c-64cbf9d12668">
<img width="420" alt="image" src="https://github.com/southrussian/EIT-Remote/assets/57446339/24e88c2a-8f71-41e1-9f80-9cfa7083d441">
<img width="458" alt="image" src="https://github.com/southrussian/EIT-Remote/assets/57446339/6dfc7282-4851-4991-8dcc-8bb204a2df68">

How it is working in pair with electrical impedance tomography device:

<img width="507" alt="image" src="https://github.com/southrussian/EIT-Remote/assets/57446339/0429e1f0-6680-4a81-b6b8-47f1ad830f6e">




