unix:!android {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target
}

export(INSTALLS)

DISTFILES += \
    $$PWD/build/Qt-Android_for_armeabi_v7a_GCC_4_9_Qt_5_5_1-Debug/android-build/AndroidManifest.xml


SOURCES += \
