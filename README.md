# cCanvasButton

cCanvasButton is a custom control for XOJO and as the name implies a button based on a Canvas Control.
The button can function as a "Push Button", "Toggle Button" or "Sticky Button" and it has six different modes - namely:

* Normal
* Hover
* Down
* Toggled
* Hover Toggled
* Down Toggled

In fact it has 12 different modes because all 6 modes can be individually configured to "Dark Mode".

The button supports alpha and thus you can use images with alpha channels. Both as actual images and as alpha masks. Even at the same time.

The images are scaled to fit the dimensions of the button - watch out for aspect ratio

In addition, you can use a background colour which can be modified with rounded corners and used to make round buttons.

The mouse cursor can be set for Hover and Down.

Everything can be configured in the IDE or during runtime.

This repo holds the control and a project that shows some of the possibilities of cCanvasButton.

In this GIF you can see how to create a transparent and colored button with a black and white alpha file.

![out](https://user-images.githubusercontent.com/1135350/151110419-c69984d6-5571-4d6e-be46-340573f42b45.gif)
