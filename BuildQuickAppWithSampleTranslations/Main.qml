import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Translation example")

    Item {
        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            anchors.fill: parent
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10
                Repeater {
                    model: ListModel {
                        ListElement {name: "English"; language: "en"}
                        ListElement {name: "简体中文"; language: "zh_CN"}
                        ListElement {name: "日本語"; language: "jp"}
                        ListElement {name: "En français"; language: "fr"}
                    }
                    delegate: RadioButton {
                        text: name
                        onClicked: {
                            Qt.uiLanguage = language;
                            console.log("uiLanguage:",Qt.uiLanguage, language);
                        }
                    }
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 32
                text: qsTr("Hello, automatic translation.")
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
}
