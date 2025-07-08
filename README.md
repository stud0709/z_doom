# z_doom
## DOOM for SAP GUI

[Will it run DOOM?](https://www.reddit.com/r/itrunsdoom/) - Yes, it will.

### Prerequisites
- SAP GUI 7.70+
- AS ABAP 1909 or later (if you don't have one, you can get the [Developer Edition](https://blogs.sap.com/2021/02/16/sap-abap-platform-1909-developer-edition-installation-on-windows-os/))

### Installation
*Update 20250708:* Many things changed since I created this repository. The [current version](https://www.sap.com/documents/2019/09/c86f9218-687d-0010-87a3-c30de2ffd8ff.html) of miniSAP is not dockerized any more, and the default hostname has changed. Please refer to Issues [#1](https://github.com/stud0709/z_doom/issues/1) and [#2](https://github.com/stud0709/z_doom/issues/2) for more details. Also, Edge is now the default HTML Control, so you can skip the 1st step. And - missing on the list - you need to create the SICF with zcl_doom_http_handler as HTTP handler class.

- Go to your Client's "Customize Local Layout (Alt+F12)" dialog -> Interaction Design -> Control Settings and change HTML Control to Edge.
- Set logon data for the service z_doom in transaction SICF if you don't want the login dialog to pop up every time.
- Call transation z_doom.
- Enjoy!

### Almost perfect...
- Mouse is not available
- ESC is captured by SAP GUI and not sent to the game. Use virtual keyboard in the game window to press ESC
- Feel free to contribute!

![Screenshot](screenshot.png)
