import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Controls
import Score.UI as UI

Rectangle {
  color: "white"
  width: 640
  height: 480
  Component.onCompleted: Score.play();

  Column {
    Label { text: "Operating a control (Zoom on some_shader):" }
    Dial {
      UI.PortSource on value {
        process: "some_shader"
        port: 1
      }
    }

    Label { text: "Reading the value of a control inlet:" }
    Label {
      UI.PortSource on text {
          process: "LFO"
          port: "Ampl."
      }
    }

    Label { text: "Reading the value of any outlet by adding a value display:" }
    Label {
      UI.PortSource on text {
          process: "Value display"
          port: 0
      }
    }

    Label { text: "Reading the value of any address:" }
    Label {
      UI.AddressSource on text {
          address: "OSC:/foo"
          sendUpdates: false
      }
    }

    Label { text: "Setting the value of any address:" }
    Dial {
      UI.AddressSource on value {
          address: "OSC:/bar"
          receiveUpdates: false
      }
    }
  }
}

