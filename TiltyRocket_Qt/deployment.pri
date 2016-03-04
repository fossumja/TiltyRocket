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
    $$PWD/build/Qt-Android_for_armeabi_v7a_GCC_4_9_Qt_5_5_1-Debug/android-build/AndroidManifest.xml \
    $$PWD/build/Qt_5_5_1_for_Windows_Phone_x86_MSVC2013_32bit_Emulator/debug/AppxManifest.xml \
    $$PWD/build/Qt_5_5_1_for_Windows_Phone_arm_MSVC2013_32bit/debug/AppxManifest.xml


SOURCES += \
